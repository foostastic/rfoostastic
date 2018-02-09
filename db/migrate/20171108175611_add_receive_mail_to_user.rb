class AddReceiveMailToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :receives_mail, :boolean
  end
end
