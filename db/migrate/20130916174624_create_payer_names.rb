class CreatePayerNames < ActiveRecord::Migration
  def change
    create_table :payer_names do |t|
      t.references :payer
      t.string :name

      t.timestamps
    end

    add_index :payer_names, :payer_id
    add_index :payer_names, :name
  end
end
