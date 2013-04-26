class AnagramDictionary < ActiveRecord::Base
  attr_accessible :sortedword, :word
    validates :sortedword, :presence => true
    validates :word, :presence => true
    validates :word, :uniqueness => true
    validates :word, :format => { :with => /\A[a-zA-zA]+\z/, :message => "Dictionary word must contain only letters"}
    #and we have to validate the uniqueness of word
    #because we shouldn't store the same word twice really

    def self.insert_many(words)
	
	#Ooops forgot that the design brief said don't use 3rd party libraries to load the
	#mysql. Leaving this here to remind me that this is an awesome way to do it
    #aWords.each_with_index do |word|
	#    sorted = word.chars.sort { |a, b| a.casecmp(b) }.join
    #    anagrams << self.new(:sortedword => sorted, :word => word)
    #end
    #insert_count = self.import anagrams, :validate => true
	
	#we wrap all our object creation in one transaction to limit
	#the number of times we hit the db. Alternatively we could
	#just write raw SQL for greater speed gains but then you lose
	#data validations. Which is why activerecord-import would have been
	#nice to use
	insert_count = 0
        ActiveRecord::Base.transaction do
            words.each do |word|
                sorted = word.chars.sort { |a, b| a.casecmp(b) }.join
                obj = self.create(:word => word, :sortedword => sorted)
		#we test if the word created a valid entry so that we can return a count of the words which were
		#inserted
		if obj.valid?
		    insert_count += 1
		end
            end
        end
	return insert_count
    end

end
