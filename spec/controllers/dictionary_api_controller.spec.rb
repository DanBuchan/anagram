require 'spec_helper'

describe DictionaryApiController do
	
	let(:expected){ _expected = []; _expected << {"message" => "we good"}.to_json}
	let(:dictionary) { "three\ntree" }
	let(:invalid_dictionary) { "three\ntree" }
	let(:create_valid)     { get "create", :format => :json, :dictionary => dictionary }
	let(:create_invalid)     { get "create", :format => :json, :dictionary => invalid_dictionary }

    describe "GET :create" do
                
        it "returns http success" do
            create_valid.response.should be_success
        end
        
        it "returns the success response for valid data" do
            message = JSON.parse(create_valid.response.body)
            message.should == expected 
        end
        
        it "returns the partial insert response for invalid data" do
            message = JSON.parse(create_invalid.response.body)
            message.should_not == expected
        end
    end

end
