class AddKarmaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :karma, :integer, default: 0
  end
end