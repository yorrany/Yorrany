class AddPositionToCertifications < ActiveRecord::Migration[8.1]
  def change
    add_column :certifications, :position, :integer
  end
end
