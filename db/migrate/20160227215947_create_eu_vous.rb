class CreateEuVous < ActiveRecord::Migration
  def change
    create_table :eu_vous do |t|
			t.references :attendee,  index: true
			t.references :attended_event,  index: true
      t.timestamps null: false
    end
		
		add_index :eu_vous, [:attendee_id, :attended_event_id], unique: true
  
  end
end
