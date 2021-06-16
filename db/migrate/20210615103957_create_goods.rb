class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :goods_condition
      t.string :delivery_condition
      t.string :area
      t.text :description
      t.integer :price
      t.string :size

      t.timestamps
    end
    add_index :goods, [:user_id, :created_at]
  end
end
