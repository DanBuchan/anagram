require 'spec_helper'

describe AnagramApiController do

    describe "GET create_dictionary" do
        
        _expected = []
        _expected << {"message" => "we good"}.to_json
        
        it "returns http success" do
            get "create_dictionary", :format => :json, :dictionary => "three,tree"
            #puts response.body.inspect
            #puts response.status.inspect
            response.should be_success
        end
        
        it "returns the success response for valid data" do
            get "create_dictionary", :format => :json, :dictionary => "three,tree"
            
            message = JSON.parse(response.body)
            message.should == _expected 
        end
        
        it "returns the partial insert response for invalid data" do
            get "create_dictionary", :format => :json, :dictionary => "three,1234"
            message = JSON.parse(response.body)
            message.should_not == _expected
        end
    end

    describe "GET get_anagrams" do
        
        _expected = []
        _expected << {"word" => "three"}.to_json
        
        it "returns http success" do
            get :get_anagrams, :format => :json, :word => 'three'
            response.should be_success
        end
        
        it "returns word list on sucessful query" do
            AnagramDictionary.create(:sortedword => 'eehrt',:word => 'three')
            get :get_anagrams, :format => :json, :word => 'three'
            message = JSON.parse(response.body)
            message.should == _expected
        end
        
        it "returns no words on unsucessful query" do
            AnagramDictionary.create(:sortedword => 'eehrt',:word => 'three')
            get :get_anagrams, :format => :json, :word => 'blarg'
            message = JSON.parse(response.body)
            message.should == []
        end
    end
    
end
