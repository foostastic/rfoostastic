class AddDivisionTitleToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :division_title, :string
  end
end
