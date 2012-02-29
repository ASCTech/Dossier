class AddIndexes < ActiveRecord::Migration
  def change
    add_index :documents, :source_system_id
    add_index :documents, :owner_id
    add_index :documents, [:source_system_id, :owner_id]

    add_index :tags, :name

    add_index :source_systems, :name
    add_index :source_systems, :api_key
  end
end
