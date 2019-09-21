class Competitor < ApplicationRecord
  belongs_to :competition
  has_many :picks
  has_many :teams, through: :picks
end
