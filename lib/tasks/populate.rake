namespace :db do
   desc "Load seed fixtures (from db/populate) into the current
         environment's database."
   task :populate => :environment do
      require 'active_record/fixtures'
      Dir.glob(RAILS_ROOT + '/db/populate/*.csv').each do |file|
         Fixtures.create_fixtures('db/populate', File.basename(file, '.*'))
      end
   end
end

