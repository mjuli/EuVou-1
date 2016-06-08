class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :reportee, index: true, foreign_key: true
      t.references :reported_event, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :reports, [:reportee_id, :reported_event_id], unique: true
  
  end
end
