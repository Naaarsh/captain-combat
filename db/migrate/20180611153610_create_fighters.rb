class CreateFighters < ActiveRecord::Migration[5.0]
  def change
    create_table :fighters do |t|
      t.string :name
      t.integer :life
      t.integer :attack
      t.integer :dodge
      t.integer :critical
      t.text :bio

      t.timestamps
    end
  end
end
