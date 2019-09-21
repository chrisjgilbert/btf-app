class Pick < ApplicationRecord
  belongs_to :team
  belongs_to :competitor, required: false
end
