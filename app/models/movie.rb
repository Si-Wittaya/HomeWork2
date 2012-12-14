class Movie < ActiveRecord::Base
def self.all_ratings
  @all_rating = ['G', 'PG', 'PG-13','NC-17', 'R']
end
end
