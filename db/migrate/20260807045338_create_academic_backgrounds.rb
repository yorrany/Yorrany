class CreateAcademicBackgrounds < ActiveRecord::Migration[8.1]
  def change
    create_table :academic_backgrounds do |t|
      t.timestamps
    end
  end
end
