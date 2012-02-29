class CreateDocumentTags < ActiveRecord::Migration
  def change
    create_table :document_tags do |t|
      t.references :document
      t.references :tag
      t.timestamps
    end

    add_index :document_tags, :document_id
    add_index :document_tags, :tag_id

  end
end
