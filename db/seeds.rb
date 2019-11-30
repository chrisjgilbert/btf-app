require 'csv'

Dir.glob("#{Rails.root}/db/seeds/*.csv").map do |file|
  competition = nil
  favourite = nil
  competitor = nil
  start_date = nil
  end_date = nil
  competitor_count = 0

  csv_text = File.read(file)
  csv = CSV.parse(csv_text, :headers => false)
  csv.each.with_index do |row, index|
    # competition
    if index == 0
      puts "************************************"
      puts "******Creating new competition******"
      puts "************************************"
      puts "Creating #{row}"
      competition = Competition.new(name: row.join)

      if competition.save
        puts "Created #{competition.name}"
      else
        puts "Failed to create #{competition.name}"
      end
    # start date
    elsif index == 1
      date = row.join.split(",")
      start_date = Date.new(date[0].to_i, date[1].to_i, date[2].to_i)
      if competition.update(start_date: start_date)
        puts "Added start date of #{start_date} to #{competition.name}"
      else
        puts "Failed to add a start date to #{competition.name}"
      end
    # end date
    elsif index == 2
      date = row.join.split(",")
      end_date = Date.new(date[0].to_i, date[1].to_i, date[2].to_i)
      if competition.update(end_date: end_date)
        puts "Added end date of #{end_date} to #{competition.name}"
      else
        puts "Failed to add a end date to #{competition.name}"
      end
    # location
    elsif index == 3
      location = row.join(",")
      if competition.update(location: location)
        puts "Added location of #{location} to #{competition.name}"
      else
        puts "Failed to add a location to #{competition.name}"
      end
      # previous winner
    elsif index == 4
      previous_winner = row.join(",")
      if competition.update(previous_winner: previous_winner)
        puts "Added previous winner of #{previous_winner} to #{competition.name}"
      else
        puts "Failed to add a previous winner to #{competition.name}"
      end
      # research link
    elsif index == 5
      research_link = row.join(",")
      if competition.update(research_link: research_link)
        puts "Added research link of #{research_link} to #{competition.name}"
      else
        puts "Failed to add a research link  to #{competition.name}"
      end
    # favourite
    elsif index == 6
      favourite = Competitor.new(name: row.join, competition_id: competition.id)
      if favourite.save
        puts "Created #{favourite.name} and added to #{competition.name}"
        competitor_count += 1
      else
        puts "Failed to create #{favourite.name}"
      end
    # competitors
    else
      competitor = Competitor.new(name: row.join, competition_id: competition.id)
      if competitor.save
        puts "Created #{competitor.name} and added to #{competition.name}"
        competitor_count += 1
      else
        puts "Failed to create #{competitor.name}"
      end
    end
  end

  if competition.update(favourite_id: favourite.id)
    puts "Set #{favourite.name} as #{competition.name} favourite"
  else
    puts "Failed to add #{favourite.name} to #{competition.name}"
  end

  puts "************************"
  puts "Created #{competition.name} with a start date of #{competition.start_date} and end date of #{competition.end_date}..."
  puts "The favourite is #{favourite.name}"
  puts "Added #{competitor_count} competitors...."
  puts "************************"
end

ryder_cup = Competition.find_by_name('Golf - Ryder Cup Winning Margin')
ryder_cup.favourite_id = nil
ryder_cup.save!

puts "Set #{ryder_cup.name} favourite id to be #{ryder_cup.favourite_id == nil ? 'nil' : 'not nil'}"

# League creation
league = League.new(name: 'The BTF Leaderboard')
if league.save
  puts "Created #{league.name}"
else
  puts "Failed to create #{league.name}"
end

puts "************************"
puts "****Seeding complete****"
puts "************************"
