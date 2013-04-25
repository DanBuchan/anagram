class CreateAnagramDictionaries < ActiveRecord::Migration
  def up
    create_table :anagram_dictionaries do |t|
        t.string :sortedword, :null => false
        t.string :word, :null => false
    end
    add_index :anagram_dictionaries, :sortedword
  end
    
  def down
      drop_table :anagram_dictionaries
  end
    
end
