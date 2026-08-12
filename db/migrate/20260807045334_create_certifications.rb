class CreateCertifications < ActiveRecord::Migration[8.1]
  def change
    create_table :certifications do |t|
      t.string :year
      t.string :badge_code
      t.string :credential_url

      t.timestamps
    end
  end
end
