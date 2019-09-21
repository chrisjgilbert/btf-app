class Competition < ApplicationRecord
  default_scope { order('competitions.start_date') }
  has_many :competitors

  def self.order_by_start_date(index)
    order('competitions.start_date').take(index).last
  end
end
