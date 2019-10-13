class League < ApplicationRecord
  belongs_to :user, optional: true
  has_many :league_memberships
  has_many :teams, through: :league_memberships

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

  def join(team_id)
    LeagueMembership.create(league_id: self.id, team_id: team_id)
  end

  def is_btf_main_league?
    self.id == 1 # BTF Main League's ID is 1
  end

  def teams
    league_memberships.map { |lm| lm.team }.sort_by(&:points).reverse
  end

  def position(team)
    teams.index(team) + 1
  end
end
