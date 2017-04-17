class RemoveCreditFromUser < ActiveRecord::Migration[5.0]
  def up
    change_table :users do |t|
        t.remove :credit, :shares_value
    end

    change_table :shares do |t|
        t.remove :user_id
        t.belongs_to :user_season, index:true
    end

    change_table :players do |t|
        t.belongs_to :season, index:true
    end
  end

  def down
    change_table :users do |t|
        t.decimal :credit, precision:20, scale:6, default: 0
        t.decimal :shares_value, precision:20, scale:6, default: 0
    end

    change_table :shares do |t|
        t.belongs_to :user, index:true
        t.remove :user_season_id
    end

    change_table :players do |t|
        t.remove :season_id
    end

  end
end
