class AnagramApiController < ApplicationController
    
    #Not yet implemented methods
    #delete_dictionary
    #update_dictionary
    
    #get_anagrams
    def show
        output = []
		output = AnagramDictionary::return_anagrams(params[:word])
	
        #Have the model grab the anagrams and return them as a chunk of json
        respond_to do |format|
            format.json { render :json => output.to_json }
        end
    end
    
end
