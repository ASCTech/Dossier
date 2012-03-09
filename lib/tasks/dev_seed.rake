namespace :db do
  namespace :development do

    desc 'drop, create, schema load, seed and populate'
    task :recreate => ['db:drop', 'db:create', 'db:schema:load', 'db:seed', :populate]

    desc 'populates the DB with fake data'
    task :populate => :environment do
      brain = SourceSystem.create!(:name => 'Brain',    :api_key => '72356d35079246030db0f76802811ef153fa06dc')
      hal   = SourceSystem.create!(:name => 'Hal 9000', :api_key => 'dffaa10c3188f049c26a1104b4f3f5c09961f7dd')
      doc = brain.documents.create!(:owner_id => 93507, :uploader_id => 7171202, :file => File.open("#{Rails.root}/Gemfile"))
      cog = Tag.create!(:name => 'Certificate of Greatness')
      DocumentTag.create!(:document_id => doc, :tag_id => cog)
    end
  end
end
