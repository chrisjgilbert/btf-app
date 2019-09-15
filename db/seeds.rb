# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


olympics = ['Usain Bolt', 'Justin Gatlin', 'Phil Anscombe']
rwc = ['England', 'Wales', 'New Zealand', 'South Africa']
golden_boot = ['Sergio Aguero', 'Harry Kane', 'Marcus Rashford']
ashes = ['Steve Smith', 'Ben Stokes', 'Jofra Archer', 'David Warner']

o = Competition.create(name: 'Olympics')
olympics.each do |player|
  Competitor.create(name: player, competition_id: o.id)
end

r = Competition.create(name: 'Rugby World Cup')
rwc.each do |player|
  Competitor.create(name: player, competition_id: r.id)
end

g = Competition.create(name: 'Premiership Football Golden Boot')
golden_boot.each do |player|
  Competitor.create(name: player, competition_id: g.id)
end

a = Competition.create(name: 'Ashes Player of the Series')
ashes.each do |player|
  Competitor.create(name: player, competition_id: a.id)
end