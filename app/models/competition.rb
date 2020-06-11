class Competition < ApplicationRecord
  default_scope { order('competitions.end_date') }
  has_many :competitors

  def self.favourites
    [192, 119, 345, 442, 508, 502, 157, 222, 452, 276, 422, 97, 472, 1, 27, 554, 302, 377, 333, 202, 464, 533, 11, 77]
  end

  def favourite
    Competitor.find(self.favourite_id)
  end

  def transfer_window_open?
    return false unless transfer_deadline.present?

    DateTime.now < self.transfer_deadline
  end

  def picked_competitor_by_team(team)
    team.picks.find { |pick| pick.competitor.competition_id == self.id }.competitor
  end

  def competitors_sorted_by_pick_count
    self.competitors.select { |competitor| competitor.picks.count > 0 }.sort_by { |competitor| competitor.picks.count }.reverse
  end

end
