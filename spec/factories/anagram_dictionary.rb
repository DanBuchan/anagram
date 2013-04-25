require 'faker'

FactoryGirl.define do
    factory :anagram_dictionary do |f|
        f.word { Faker::Lorem.word }
        f.sortedword { f.word.to_s.chars.sort { |a, b| a.casecmp(b) }.join }
    end
    
end