class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.string :title
      t.text :body
      t.integer :amount
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
