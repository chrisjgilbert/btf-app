require 'csv'

namespace :users do
  desc "Read CSV of paid users and set them to paid"
  task set_to_paid: :environment do
    file = './user that have paid.csv'
    csv = CSV.parse(File.read(file), :headers => true)
    csv.each do |user|
      email = user[2]
      User.update_payment_status_to_true(email)
    end
  end
end
