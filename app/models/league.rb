class League < ApplicationRecord
  belongs_to :user, optional: true
  has_many :teams, through: :league_memberships
  has_many :league_memberships

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

  def join(team_id)
    LeagueMembership.create(league_id: self.id, team_id: team_id)
  end
end
