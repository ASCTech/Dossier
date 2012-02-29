class CreateSourceSystems < ActiveRecord::Migration
  def change
    create_table :source_systems do |t|
      t.string :name
      t.string :api_key
      t.timestamps
    end
  end
end
