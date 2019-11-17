class Competition < ApplicationRecord
  default_scope { order('competitions.start_date') }
  has_many :competitors

  # def self.order_by_start_date(index) # TODO: check if this is actually doing anything
  #   order('competitions.start_date').take(index).last
  # end

  def self.favourites
    all.map(&:favourite_id)
    # [21, 512, 1846, 170, 502, 916, 1852, 812, 662, 1166, 9, 1877, 1784, 2001, 861, 1816, 926, 202, 1, 1466, 832, 1484, 2027, 146, 1804]
  end

  def favourite
    Competitor.find(self.favourite_id)
  end

end
