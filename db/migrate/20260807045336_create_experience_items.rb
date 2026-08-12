class CreateExperienceItems < ActiveRecord::Migration[8.1]
  def change
    create_table :experience_items do |t|
      t.string :period
      t.string :location

      t.timestamps
    end
  end
end
