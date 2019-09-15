class Team < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
end
