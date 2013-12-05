namespace :db do
  desc "Drop, create, migrate, seed the database"
  task :bootstrap => :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end

  namespace :dev do
    desc "Rollback to 0, migrate, and seed the dev database"
    task :remigrate => :environment do
      Rails.env = "development"
      system("rake db:migrate VERSION=0")
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed'].invoke
    end
  end

  namespace :test do
    desc "Drop, create, migrate the test database"
    task :bootstrap => :environment do
      Rails.env = 'test'
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
    end
  end
end