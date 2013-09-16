class CreatePayers < ActiveRecord::Migration
  def change
    create_table :payers do |t|
      t.string :payer_id

      t.timestamps
    end

    add_index :payers, :payer_id, unique: true
  end
end
