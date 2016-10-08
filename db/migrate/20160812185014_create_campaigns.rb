class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.integer :goal
      t.datetime :end_date

      t.timestamps
    end
  end
end
