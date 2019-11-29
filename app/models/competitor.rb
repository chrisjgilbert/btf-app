class Competitor < ApplicationRecord
  default_scope { order(:name) } # uncomment this line for alphabetically ordered competitors
  belongs_to :competition
  has_many :picks
  has_many :teams, through: :picks

  def captains_teams?(team)
    team.captain_id == self.id
  end

  def is_favourite?
    Competition.favourites.include?(self.id)
  end

  def name_with_favourite_status
    is_favourite? ? "#{name} (Favourite)" : "#{name}"
  end

  def favourite_status
    is_favourite? ? 'favourite' : ''
  end

  def award_points(points)
    current_points = self.points
    new_points_total = current_points + points
    if update(points: new_points_total)
      "#{self.name} now has #{self.points} points. Previously they had #{current_points}"
    else
      "There was a problem updating #{self.name} points"
    end
  end
end
