class DictionaryApiController < ApplicationController

    #create_dictionary
    def create
        #Here we load the dictionary and at the end we return a chunk of json to report success
     	failed_instances = AnagramDictionary::insert_many(params[:dictionary])	
	
        respond_to do |format|
            #Make sure the json is formatted correctly or jQuery .ajax() won't behave
            output = []
            if failed_instances > 0
                output << {"message" => failed_instances.to_s+" words did not load"}.to_json
                format.json { render :json => output, :status => :ok }
            else
                output << {"message" => "we good"}.to_json
                format.json { render :json => output, :status => :ok }
            end
        end
    end
    
    #Not yet implemented methods
    #destroy
    #update
	    
end
