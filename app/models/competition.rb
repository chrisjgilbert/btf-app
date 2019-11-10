class Competition < ApplicationRecord
  default_scope { order('competitions.start_date') }
  has_many :competitors

  # def self.order_by_start_date(index) # TODO: check if this is actually doing anything
  #   order('competitions.start_date').take(index).last
  # end

  def self.favourites
    all.map(&:favourite_id)
  end

  def favourite
    Competitor.find(self.favourite_id)
  end

end
