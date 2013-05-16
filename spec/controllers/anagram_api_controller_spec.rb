require 'spec_helper'

describe AnagramApiController do
	
	let(:word)              { "three" }
    let(:sortedword)        { "eehrt" }
    let(:invalid_word)      { "blart" }
    let(:expected)          { _expected = []; _expected << {"word" => word}.to_json}
	let(:get_show)          { get "show", :format => :json, :word => word }
	#should switch this let to before()
	let(:create_dictionary) { AnagramDictionary.create(:sortedword => sortedword,:word => word ) } 
	let(:get_anagram)       { get :show, :format => :json, :word => word }
	let(:no_anagram)        { get :show, :format => :json, :word => invalid_word }
	
	describe "GET :show" do
        
        it "returns http success" do
			get_show
			response.should be_success
        end
        
        it "returns word list on sucessful query" do
			create_dictionary
            get_anagram
            message = JSON.parse(response.body)
            message.should == expected
        end
        
        it "returns no words on unsucessful query" do
			create_dictionary
            no_anagram
			message = JSON.parse(response.body)
            message.should == []
        end
    end
    
end
