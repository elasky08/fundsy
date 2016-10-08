class AddAasmStateToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :aasm_state, :string
    add_index :campaigns, :aasm_state
  end
end
