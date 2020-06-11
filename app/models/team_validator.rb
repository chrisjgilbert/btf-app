class TeamValidator < ActiveModel::Validator
  FAVOURITE_LIMIT = 5
  TRANSFER_LIMIT  = 500
  NUMBER_OF_PICKS = Competition.all.count
  def validate(record)
    picks = record.picks.reject { |pick| pick.competitor_id == nil }
    if picks.count != NUMBER_OF_PICKS
      record.errors[:base] << "You need to pick a competitor for every event"
    end
    if picks.select { |pick| pick.competitor.is_favourite? }.count > FAVOURITE_LIMIT
      record.errors[:base] << "Please review your team, you cannot have more than #{FAVOURITE_LIMIT} favourites"
    end
    if record.transfers_made > TRANSFER_LIMIT
      record.errors[:base] << "Please review your team, you cannot make more than #{TRANSFER_LIMIT} transfers"
    end
    if record.captain_id == nil
      record.errors[:base] << "You need to select a captain"
    end
  end
end
