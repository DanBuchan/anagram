class AnagramApiController < ApplicationController

    #create_dictionary
    def create_dictionary
        #Here we load the dictionary and at the end we return a chunk of json to report success
        text = params[:dictionary]
        aWords = text.split(",")
        @dictionary = AnagramDictionary.new()
        
        #use activerecord-import so we only have to do a single db transaction
        anagrams = []
        total_words = aWords.length
	    
	insert_count = AnagramDictionary::insert_many(aWords)	
	failed_instances = total_words - insert_count
	
        respond_to do |format|
            #Make sure the json is formatted correctly or jQuery .ajax() won't behave
            output = []
            if failed_instances > 0
                output << {"message" => failed_instances.to_s+" words out of "+total_words.to_s+" words did not load"}.to_json
                format.json { render :json => output, :status => :ok }
            else
                output << {"message" => "we good"}.to_json
                format.json { render :json => output, :status => :ok }
            end
        end
    end
    
    #Not yet implemented methods
    #delete_dictionary
    #update_dictionary
    
    #get_anagrams
    def get_anagrams
        word = params[:word]
        sorted = word.chars.sort { |a, b| a.casecmp(b) }.join
        #technically we shouldn't evaluate the SQL like this but as it's sorted it'll be safe
        results = AnagramDictionary.find(:all, :conditions => "sortedword=\"#{sorted}\"")
        
        output = []
        results.each_with_index do |result, i|
            output << {"word" => result.word}.to_json
        end
        
        logger.debug output
        #Have the model grab the anagrams and return them as a chunk of json
        respond_to do |format|
            format.json { render :json => output.to_json }
        end
    end
    
end
