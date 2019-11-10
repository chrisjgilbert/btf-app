class TeamValidator < ActiveModel::Validator
  FAVOURITE_LIMIT = 5
  def validate(record)
    if record.picks.select { |pick| pick.competitor.is_favourite? }.count > FAVOURITE_LIMIT
      record.errors[:base] << "You can't choose more than #{FAVOURITE_LIMIT} favourites"
    end
    if record.captain_id == nil
      record.errors[:base] << "You must chose a captain"
    end
  end
end
