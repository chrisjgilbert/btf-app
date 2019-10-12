class Competitor < ApplicationRecord
  belongs_to :competition
  has_many :picks
  has_many :teams, through: :picks

  def captains_teams?(team)
    team.captain_id == self.id
  end
end
