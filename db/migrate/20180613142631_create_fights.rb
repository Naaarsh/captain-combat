class CreateFights < ActiveRecord::Migration[5.0]
  def change
    create_table :fights do |t|
      t.text :history
      t.integer :winner_id
      t.integer :looser_id

      t.integer :fighter_one_id
      t.integer :fighter_two_id


      t.timestamps
    end
  end
end
