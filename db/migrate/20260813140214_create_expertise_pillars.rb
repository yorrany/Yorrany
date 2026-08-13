class CreateExpertisePillars < ActiveRecord::Migration[8.1]
  def change
    create_table :expertise_pillars do |t|
      t.integer :position

      t.timestamps
    end
  end
end
