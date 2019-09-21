class Pick < ApplicationRecord
  belongs_to :team, required: false
  belongs_to :competitor, required: false
end
