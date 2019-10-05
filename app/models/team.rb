class Team < ApplicationRecord
  belongs_to :user
  has_many :picks, -> { order(created_at: :asc) }
  has_many :competitors, through: :picks
  accepts_nested_attributes_for :picks
  has_many :league_memberships
  has_many :leagues, through: :league_memberships

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  def join_main_btf_league
    LeagueMembership.create(team_id: self.id, league_id: 1) # 1 is the BTF Main League
  end

  def belongs_to_league?(league_id)
    LeagueMembership.where(team_id: self.id, league_id: league_id).exists?
  end
end
