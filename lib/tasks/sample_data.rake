require 'faker'

namespace :db do
  desc "Peupler la base de données"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    administrateur = User.create!(:nom => "Allolaterre",
                                  :email => "terre@mailex.org",
                                  :password => "popopo",
                                  :password_confirmation => "popopo")
    administrateur.toggle!(:admin)
    3.times do |n|
      nom  = Faker::Name.name[5..17]
      email = "example-#{n+1}@mailex.org"
      password  = "motdepasse"
      User.create!(:nom => nom,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    User.all.each do |user|
      10.times do
        user.books.create!(:titre => Faker::Lorem.words(1),
                           :auteur => Faker::Lorem.words(1))
      end
    end
  end
end