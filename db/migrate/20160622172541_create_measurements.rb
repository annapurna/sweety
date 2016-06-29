class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :measured_value
      t.integer :user_id
      t.datetime :measured_at

      t.timestamps
    end
  end
end
