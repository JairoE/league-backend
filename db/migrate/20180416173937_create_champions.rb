class CreateChampions < ActiveRecord::Migration[5.1]
  def change
    create_table :champions do |t|
      t.integer :champ_id
      t.string :name
      t.string :image_url
      t.string :nickname
      t.timestamps
    end
  end
end
