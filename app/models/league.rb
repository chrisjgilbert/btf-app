class League < ApplicationRecord
  belongs_to :user, optional: true
  has_many :teams, through: :league_memberships
  has_many :league_memberships
end
