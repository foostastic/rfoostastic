class CreateShares < ActiveRecord::Migration[5.0]
  def change
    create_table :shares do |t|
      t.integer :amount
      t.decimal :buy_price, precision:20, scale:6
      t.belongs_to :player, index:true
      t.belongs_to :user, index:true

      t.timestamps
    end
  end
end
