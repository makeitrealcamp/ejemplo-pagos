class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.string :uid, limit: 50
      t.integer :status, default: 0
      t.integer :payment_method, default: 0
      t.decimal :amount
      t.text :error_message

      t.timestamps
    end
  end
end
