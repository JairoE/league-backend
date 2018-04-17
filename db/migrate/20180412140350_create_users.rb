class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :summonerName
      t.integer :summonerId
      t.integer :accountId
      t.integer :profileIconId
      t.integer :summonerLevel
      t.string :email
      t.timestamps
    end
  end
end
