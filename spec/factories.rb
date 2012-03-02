FactoryGirl.define do

  factory :document do
    owner_id 93507
    uploader_id 7171202
    source_system
  end

  factory :source_system do
    name 'ENIAC'
    api_key '20tn20tnjo20480tn4n20429042j'
  end

  factory :tag do
    name 'mathematical'
  end

end
