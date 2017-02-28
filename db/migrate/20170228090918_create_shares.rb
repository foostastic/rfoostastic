class CreateShares < ActiveRecord::Migration[5.0]
  def change
    create_table :shares do |t|
      t.integer :amount
      t.bigint :buy_price
      t.belongs_to :player, index:true
      t.belongs_to :user, index:true

      t.timestamps
    end
  end
end
