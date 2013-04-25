class AnagramDictionary < ActiveRecord::Base
  attr_accessible :sortedword, :word
    validates :sortedword, :presence => true
    validates :word, :presence => true
    validates :word, :uniqueness => true
    validates :word, :format => { :with => /\A[a-zA-zA]+\z/, :message => "Dictionary word must contain only letters"}
    #and we have to validate the uniqueness of word
    #because we shouldn't store the same word twice really

    def self.insert_many(words)
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
