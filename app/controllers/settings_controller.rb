class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to root_path, success: "Your settings has been updated"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:api_key)
  end
end
