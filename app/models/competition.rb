class Competition < ApplicationRecord
  default_scope { order('competitions.end_date') }
  has_many :competitors

  def self.favourites
    all.map(&:favourite_id)
  end

  def favourite
    Competitor.find(self.favourite_id)
  end

  def transfer_window_open?
    return false unless transfer_deadline.present?

    DateTime.now < self.transfer_deadline
  end

end
