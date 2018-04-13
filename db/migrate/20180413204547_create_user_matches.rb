class CreateUserMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :user_matches do |t|
      t.integer :match_id
      t.integer :user_id
      t.timestamps
    end
  end
end
