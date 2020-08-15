require 'csv'

namespace :competitions do
  desc "Update Men‘s - T20 Blast cricket comp"
  task t20_blast_update: :environment do |task, args|
    %w(
      Birmingham Bears
      Derbyshire Falcons
      Durham
      Essex Eagles
      Glamorgan
      Gloucestershire
      Hampshire
      Kent Spitfires
      Lancashire Lightning
      Leicestershire Foxes
      Middlesex
      Northamptonshire Steelbacks
      Nottinghamshire Outlaws
      Somerset
      Surrey
      Sussex Sharks
      Worcestershire Rapids
      Yorkshire Vikings
    ).each do |team|
      Competitor.create(name: team, competition_id: 19)
    end
  end

  desc "Update transfer deadline"
  task :update_transfer_deadlines, [:id] => [:environment] do |task, args|
    competitions = Competition.all
    competitions.each do |competition|
      case competition.id
      # F1
      when 4 then competition.update(transfer_deadline: DateTime.new(2020, 7, 5, 12, 0, 0).utc)
      # Euros
      when 25 then competition.update(transfer_deadline: DateTime.new(2020, 12, 1, 12, 0, 0).utc)
      # The Masters
      when 10 then competition.update(transfer_deadline: DateTime.new(2020, 11, 12, 11, 0, 0).utc)
        # Women's US Open (formerly Wimbledon)
      when 3
        competition.update(transfer_deadline: DateTime.new(2020, 8, 26, 11, 0, 0).utc)
        competition.update(name: 'Tennis - Women\'s US Open')
      # Tour de France
      when 12 then competition.update(transfer_deadline: DateTime.new(2020, 8, 29, 8, 0, 0).utc)
      # The Hundred
      when 19 then competition.update(transfer_deadline: DateTime.new(2020, 12, 1, 12, 0, 0).utc)
      end
    end 
  end
  
  desc "Cancel competitions"
  task cancel: :environment do |task, args|
    euros = 25
    womens_100 = 15
    womens_hockey = 13
    overall_olympic_cycling = 9
    comps = Competition.find(euros, womens_100, womens_hockey, overall_olympic_cycling)

    comps.each do |comp|
      comp.update(name: "#{comp.name} - CANCELLED - but available to transfer")
      comp.update(transfer_deadline: DateTime.new(2020, 12, 1, 12, 0, 0).utc)
      if comp.save
        p "SUCCESSFULLY SAVED #{comp.name}"
      else
        p "FALIED TO SAVE #{comp.name}"
      end
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
