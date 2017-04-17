class CreateUserSeasons < ActiveRecord::Migration[5.0]
  def change
    create_table :user_seasons do |t|
      t.references :user, foreign_key: true
      t.references :season, foreign_key: true

      t.decimal :credit, precision:20, scale:6, default: 0
      t.decimal :shares_value, precision:20, scale:6, default: 0

      t.timestamps
    end
  end
end
