class Competition < ApplicationRecord
  default_scope { order('competitions.end_date') }
  has_many :competitors

  def self.favourites
    all.map(&:favourite_id)
  end

  def favourite
    Competitor.find(self.favourite_id)
  end

end
