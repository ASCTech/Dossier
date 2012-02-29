namespace :db do
  namespace :development do

    desc 'drop, create, schema load, seed and populate'
    task :recreate => ['db:drop', 'db:create', 'db:schema:load', 'db:seed', :populate]

    desc 'populates the DB with fake data'
    task :populate => :environment do
      brain = SourceSystem.create!(:name => 'Brain', :api_key => '72356d35079246030db0f76802811ef153fa06dc')
      brain.documents.create!(:owner_id => 93507, :uploader_id => 7171202)
    end
  end
end
