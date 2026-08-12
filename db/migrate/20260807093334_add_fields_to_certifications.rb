class AddFieldsToCertifications < ActiveRecord::Migration[8.1]
  def change
    add_column :certifications, :skills, :string
    add_column :certifications, :credential_code, :string
    add_column :certifications, :document_title, :string
    add_column :certifications, :document_caption, :string
  end
end
