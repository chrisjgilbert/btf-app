class LeagueMembership < ApplicationRecord
  belongs_to :league
  belongs_to :team

  def self.add_team_to_league(team_id:, league_id:)
    LeagueMembership.create(team_id: team_id, league_id: league_id)
  end

  def self.join_main_btf_league(team_id)
    LeagueMembership.create(team_id: team_id, league_id: 1) # 1 is the BTF Main League
  end
end
