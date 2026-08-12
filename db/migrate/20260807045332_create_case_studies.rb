class CreateCaseStudies < ActiveRecord::Migration[8.1]
  def change
    create_table :case_studies do |t|
      t.string :image
      t.string :accent_color
      t.boolean :is_spotlight

      t.timestamps
    end
  end
end
