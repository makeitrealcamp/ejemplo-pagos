class AddResponseDataToCharges < ActiveRecord::Migration[5.2]
  def change
    add_column :charges, :response_data, :jsonb
  end
end
