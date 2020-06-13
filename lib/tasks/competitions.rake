require 'csv'

namespace :competitions do
  desc "Add transfer deadlines to Competitions"
  task :cancel, [:id] => [:environment] do |task, args|
    comp = Competition.find(args.id)

    comp.name = "#{comp.name} - CANCELLED - but available to transfer"
    if comp.save
      p "SUCCESSFULLY SAVED #{comp.name}"
    else
      p "FALIED TO SAVE #{comp.name}"
    end
  end
  task add_transfer_deadlines: :environment do
    competitions = Competition.all

    competitions.each do |competition|
      case competition.id
      when 17 then competition.update(transfer_deadline: DateTime.new(2020, 2, 20, 22, 0, 0).utc) # Feb 20th @2200
      when 1  then competition.update(transfer_deadline: DateTime.new(2020, 2, 22, 11, 0, 0).utc) # Feb 22nd @1100
      when 5  then competition.update(transfer_deadline: DateTime.new(2020, 2, 18, 20, 0, 0).utc) # Feb 18th @2000

      when 22 then competition.update(transfer_deadline: DateTime.new(2020, 3, 10, 12, 0, 0).utc) # Mar 10th @1200
      when 4  then competition.update(transfer_deadline: DateTime.new(2020, 3, 16,  5, 0, 0).utc) # Mar 16th @0500

      when 10 then competition.update(transfer_deadline: DateTime.new(2020, 4, 9,  11, 0, 0).utc) # Apr 9th  @1100

      when 25 then competition.update(transfer_deadline: DateTime.new(2020, 6, 12, 20, 0, 0).utc) # Jun 12th @2000
      when 12 then competition.update(transfer_deadline: DateTime.new(2020, 6, 27, 9,  0, 0).utc) # Jun 27th @0900
      when 3  then competition.update(transfer_deadline: DateTime.new(2020, 6, 29, 12, 0, 0).utc) # Jun 29th @1200

      when 19 then competition.update(transfer_deadline: DateTime.new(2020, 7, 17, 18, 0, 0).utc) # Jul 17th @1800
      when 9  then competition.update(transfer_deadline: DateTime.new(2020, 7, 25, 2,  0, 0).utc) # Jul 25th @0200
      when 13 then competition.update(transfer_deadline: DateTime.new(2020, 7, 25, 9,  0, 0).utc) # Jul 25th @0900
      when 15 then competition.update(transfer_deadline: DateTime.new(2020, 7, 30, 23, 0, 0).utc) # Jul 30th @2300

      when 24 then competition.update(transfer_deadline: DateTime.new(2020, 9, 28, 12, 0, 0).utc) # Sep 28th @1200

      when 2  then competition.update(transfer_deadline: DateTime.new(2020, 10, 18, 4, 0, 0).utc) # Oct 18th @0400
      end
    end 
  end
end
