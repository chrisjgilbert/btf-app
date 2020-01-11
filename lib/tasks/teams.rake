require 'csv'

namespace :teams do
  desc "Write teams to CSV filees"
  task write_to_csv: :environment do
    teams = Team.all

    teams.each do |team|
      team_name = team.name.gsub("/", " ")
      file = "team_csvs/#{team_name}.csv"
      pick_count = 0

      CSV.open(file, 'w' ) do |csv|
        csv << [team.user.first_name + " " + team.user.last_name]
        csv << [team.user.email]
        csv << [team.name]

        team.picks.each do |pick|
          if team.captain == pick.competitor
            csv << ["#{pick.competitor.name} (captain)"]
          else
            csv << [pick.competitor.name]
          end
          pick_count += 1
        end

      end
      
      if pick_count == 25
        puts "SUCCESS: created #{file} with #{pick_count} picks"
      else
        puts "WARNING: Something went wrong and only #{pick_count} picks were found"
      end
    end
    puts "#{teams.count} teams finished..."
  end
end
