class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :social_id

      t.decimal :credit, precision:20, scale:6, default: 0
      t.decimal :shares_value, precision:20, scale:6, default: 0

      t.string :name
      t.string :email
      t.string :image

      t.index :social_id, unique: true

      t.timestamps
    end
  end
end
