class ChangeColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :remember_token, :remember_digest
  end
end
