require 'faker'

namespace :db do
  desc 'Llenar la base con datos de ejemplo'
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:nombre => "Juancho",
                 :email => "jjuanchow@gmail.com",
                 :password => "juancho",
                 :password_confirmation => "juancho")
    admin.toggle!(:admin)
    99.times do |n|
      nombre = Faker::Name.name
      email = "ejemplo-#{n+1}@jezz.com.mx"
      password = "password"
      User.create!(:nombre => nombre,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end  
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:contenido => Faker::Lorem.sentence(5))
      end
    end
  end
end