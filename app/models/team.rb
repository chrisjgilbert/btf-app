class Team < ApplicationRecord
  belongs_to :user
  has_many :picks, -> { order(created_at: :asc) }
  has_many :competitors, through: :picks
  accepts_nested_attributes_for :picks
  has_one :captain, class_name: "Competitor"

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

end
