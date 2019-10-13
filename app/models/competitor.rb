class Competitor < ApplicationRecord
  belongs_to :competition
  has_many :picks
  has_many :teams, through: :picks

  def captains_teams?(team)
    team.captain_id == self.id
  end

  def is_favourite?
    Competition.where(favourite_id: self.id).exists?
  end

  def name_with_favourite_status
    is_favourite? ? "#{name} (F)" : "#{name}"
  end

  def favourite_status
    is_favourite? ? 'favourite' : ''
  end
end
