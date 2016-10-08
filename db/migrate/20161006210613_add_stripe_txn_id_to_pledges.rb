class AddStripeTxnIdToPledges < ActiveRecord::Migration[5.0]
  def change
    add_column :pledges, :stripe_txn_id, :string
  end
end
