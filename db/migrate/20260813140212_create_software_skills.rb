class CreateSoftwareSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :software_skills do |t|
      t.string :name
      t.integer :experience_years
      t.integer :position

      t.timestamps
    end
  end
end
