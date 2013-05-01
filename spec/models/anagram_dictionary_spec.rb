require 'spec_helper'

describe AnagramDictionary do
	let(:word) { "three" }
	let(:nonword) { "12345" }
	let(:sortedword) { "eehrt" }
	let(:dictionary) { "three\nthat" }
	let(:response) { response = [];	response << {"word" => word}.to_json }
	
	#test all the models validations and whether the model can be saved
    it "has a valid factory" do
        FactoryGirl.create(:anagram_dictionary).should be_valid
    end
    it "is invalid without a sortedword" do
        FactoryGirl.build(:anagram_dictionary, sortedword: nil).should_not be_valid
    end
    it "is invalid without a word" do
        FactoryGirl.build(:anagram_dictionary, word: nil).should_not be_valid
    end
    it "is invalid if word is not alphabetical" do
        FactoryGirl.build(:anagram_dictionary, word: nonword).should_not be_valid
        #Could/should add more tests of string with punctuation and so forth here
    end
    
    it "does not allow duplicate words to be inserted" do
        AnagramDictionary.create(:sortedword => sortedword,:word => word)
        FactoryGirl.build(:anagram_dictionary, word: word).should_not be_valid
    end

    it "can be instantiated" do
        AnagramDictionary.new.should be_an_instance_of(AnagramDictionary)
    end
    it "can be saved" do
        FactoryGirl.create(:anagram_dictionary).should be_persisted
    end

   it "can .insert_many" do
        AnagramDictionary.insert_many(dictionary).should == 0
   end
   
   it "will .return_anagrams" do
		AnagramDictionary.insert_many(dictionary)
		AnagramDictionary.return_anagrams(word).should eql response
   end
   
end
