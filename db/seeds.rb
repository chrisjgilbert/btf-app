require 'csv'

Dir.glob("#{Rails.root}/db/seeds/*.csv").map do |file|
  competition = nil
  favourite = nil
  competitor = nil
  competitor_count = 0

  csv_text = File.read(file)
  csv = CSV.parse(csv_text, :headers => false)
  csv.each.with_index do |row, index|

    if index == 0
      puts "****ADDING NEW COMPETITON****"
      puts "Creating #{row}"
      competition = Competition.new(name: row.join)

      if competition.save
        puts "Created #{competition.name}"
      else
        puts "Failed to create #{competition.name}"
      end

    elsif index == 1
      puts "Adding #{row} to #{competition.name}"
      favourite = Competitor.new(name: row.join, competition_id: competition.id)

      if favourite.save
        puts "Created #{favourite.name} and added to #{competition.name}"
        competitor_count += 1
      else
        puts "Failed to create #{favourite.name}"
      end

    else
      puts "Adding #{row} to #{competition.name}"
      competitor = Competitor.new(name: row.join, competition_id: competition.id)

      if competitor.save
        puts "Created #{competitor.name} to #{competition.name}"
        competitor_count += 1
      else
        puts "Failed to create #{competitor.name}"
      end
    end
  end

  if competition.update(favourite_id: favourite.id)
    puts "Added #{favourite.name} to #{competition.name}"
  else
    puts "Failed to add #{favourite.name} to #{competition.name}"
  end

  puts "************************"
  puts "Created #{competition.name}..."
  puts "The favourite is #{favourite.name}"
  puts "Added #{competitor_count} competitors...."
  puts "************************"
end

league = League.new(name: 'The BTF Main League')
if league.save
  puts "Created #{league.name}"
else
  puts "Failed to create #{league.name}"
end

puts "Seeding complete"
