class Competition < ApplicationRecord
  default_scope { order('competitions.start_date') }
  has_many :competitors
end
