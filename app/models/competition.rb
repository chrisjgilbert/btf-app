class Competition < ApplicationRecord
  default_scope { order('competitions.end_date') }
  has_many :competitors

  def self.favourites
    all.map(&:favourite_id)
    # [216, 178, 419, 409, 236, 46, 21, 124, 335, 94, 467, 487, 52, 513, 373, 564, 523, 290, 355, 261, 347, 82, 451, 1]
  end

  def favourite
    Competitor.find(self.favourite_id)
  end

end
