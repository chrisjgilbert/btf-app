class Team < ApplicationRecord
  belongs_to :user
  has_many :picks, -> { order(created_at: :asc) }
  has_many :competitors, through: :picks
  accepts_nested_attributes_for :picks
  has_many :league_memberships
  has_many :leagues, through: :league_memberships

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates_with TeamValidator

  def self.calculate_all_points
    all.map { |team| team.calculate_points }
  end

  def join_main_btf_league
    LeagueMembership.create(team_id: self.id, league_id: 1) # 1 is the BTF Main League
  end

  def belongs_to_league?(league_id)
    LeagueMembership.where(team_id: self.id, league_id: league_id).exists?
  end

  def captain
    Competitor.find(self.captain_id)
  end

  def calculate_points
    existing_points = self.points
    new_points_total = 0
    self.picks.each do |pick|
      competitor = pick.competitor
      if competitor == captain
        new_points_total += (competitor.points * 2)
      else
        new_points_total += competitor.points
      end
    end

    if update(points: new_points_total)
      "#{self.name} now has #{self.points}. They previously had #{existing_points}"
    else
      "There was a problem updating #{self.name} points"
    end
  end

  def players
    self.picks.map(&:competitor)
  end

  def leagues
    league_memberships.map(&:league)
  end
end
