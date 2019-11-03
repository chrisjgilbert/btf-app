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
    # favourite 
    elsif index == 3
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

# League creation
league = League.new(name: 'The BTF Main League')
if league.save
  puts "Created #{league.name}"
else
  puts "Failed to create #{league.name}"
end

puts "************************"
puts "****Seeding complete****"
puts "************************"
