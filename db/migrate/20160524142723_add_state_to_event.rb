class AddStateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :state, :boolean
  end
end
