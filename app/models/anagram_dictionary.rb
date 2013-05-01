class AnagramDictionary < ActiveRecord::Base
  attr_accessible :sortedword, :word
    validates :sortedword, :presence => true
    validates :word, :presence => true
    validates :word, :uniqueness => true
    validates :word, :format => { :with => /\A[a-zA-zA]+\z/, :message => "Dictionary word must contain only letters"}
    #and we have to validate the uniqueness of word
    #because we shouldn't store the same word twice really

    def self.insert_many(text)
		aWords = text.split("\n")
		total_words = aWords.length
	
	#Ooops forgot that the design brief said don't use 3rd party libraries to load the
	#mysql. Leaving this here to remind me that this is an awesome way to do it
    #aWords.each_with_index do |word|
	#    sorted = word.chars.sort { |a, b| a.casecmp(b) }.join
    #    anagrams << self.new(:sortedword => sorted, :word => word)
    #end
    #insert_count = self.import anagrams, :validate => true
	
	#we wrap all our object creation in one transaction to limit
	    insert_count = 0
     	ActiveRecord::Base.transaction do
            aWords.each do |word|
                sorted = word.chars.sort { |a, b| a.casecmp(b) }.join
                obj = self.create(:word => word, :sortedword => sorted)
		#we test if the word created a valid entry so that we can return a count of the words which were
		#inserted
		if obj.valid?
		    insert_count += 1
		end
            end
        end
	failed_instances = total_words - insert_count
	return failed_instances
    end
	
	def self.return_anagrams(word)
		sorted = word.chars.sort { |a, b| a.casecmp(b) }.join
		results = self.find(:all, :conditions => "sortedword=\"#{sorted}\"")
        
        output = []
        results.each_with_index do |result, i|
            output << {"word" => result.word}.to_json
        end
        logger.debug output
		return output
	end

end
