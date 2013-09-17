class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.references :user
      t.string :npi
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    add_index :providers, :user_id
    add_index :providers, :npi
  end
end
