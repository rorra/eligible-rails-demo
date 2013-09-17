class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types do |t|
      t.string :service_type_id
      t.string :description

      t.timestamps
    end

    add_index :service_types, :service_type_id
    add_index :service_types, :description
  end
end
