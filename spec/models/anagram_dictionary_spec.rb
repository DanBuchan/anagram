require 'spec_helper'

describe AnagramDictionary do
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
        FactoryGirl.build(:anagram_dictionary, word: "123456").should_not be_valid
        #Could/should add more tests of string with punctuation and so forth here
    end
    
    it "does not allow duplicate words to be inserted" do
        AnagramDictionary.create(:sortedword => 'eehrt',:word => 'three')
        FactoryGirl.build(:anagram_dictionary, word: "three").should_not be_valid
    end

    it "can be instantiated" do
        AnagramDictionary.new.should be_an_instance_of(AnagramDictionary)
    end
    
    it "can be saved" do
        FactoryGirl.create(:anagram_dictionary).should be_persisted
    end

   it "can insert multiple words" do
	words = ["this","that"]
        AnagramDictionary.insert_many(words).should == 2
   end
end
