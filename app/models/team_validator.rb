class TeamValidator < ActiveModel::Validator
  FAVOURITE_LIMIT = 3
  def validate(record)
    if record.picks.select { |pick| pick.competitor.is_favourite? }.count > FAVOURITE_LIMIT
      record.errors[:base] << "You can't choose more than #{FAVOURITE_LIMIT} favourites"
    end
  end
end