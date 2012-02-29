class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer    :owner_id
      t.references :source_system
      t.integer    :uploader_id
      t.datetime   :created_at, :null => false
    end
  end
end
