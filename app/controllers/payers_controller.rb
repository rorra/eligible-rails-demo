class PayersController < ApplicationController
  def index
    @payers = Payer.joins(:payer_names)
    unless params[:q].blank?
      @payers = @payers.where("payers.payer_id ilike ? or payer_names.name ilike ?", "%#{params[:q]}%", "%#{params[:q]}%")
    end
    @payers = @payers.uniq!

    respond_to do |format|
      format.json { render json: @payers.as_json(only: :payer_id, include: [payer_names: { only: :name }]) }
    end
  end
end
