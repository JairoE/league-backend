class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.string :game_id
      t.text :game_info
    end
  end
end
