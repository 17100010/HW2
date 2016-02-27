class Movie < ActiveRecord::Base
    
    
    def self.all_ratings
        @all_ratings = Hash['G' => false,'PG' => false,'PG-13' => false,'R' => false,'NC-17' => false]
    end
    
    @@counter = 0
        
    def self.counter
        @@counter = @@counter + 1
    end
    
    def self.returnC
        @@counter
    end

    
end
