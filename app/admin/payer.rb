ActiveAdmin.register Payer do
  form do |f|
    f.inputs "Payer Details" do
      f.input :payer_id
      f.has_many :payer_names do |name|
        name.input :name
      end
    end
    f.actions
  end
  controller do
    def permitted_params
      params.permit payer: [:payer_id, payer_names_attributes: [:name]]
    end
  end
end
