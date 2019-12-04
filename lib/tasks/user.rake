require 'rake'

namespace :user do
  desc "Update a user's payment status to true"
  task :paid, [:email] => :environment do |email|
    puts email
    User::update_payment_status_to_true(email)
  end
end