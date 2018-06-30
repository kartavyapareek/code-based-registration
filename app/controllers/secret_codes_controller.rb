class SecretCodesController < ApplicationController
  load_and_authorize_resource
  def index
    @codes = SecretCode.all
  end

  def create
    numbers = params[:selected_number_code]
    codes = []
    numbers.to_i.times { codes << {} }
    SecretCode.create(codes)
    flash[:success] = "Action Successful"
    redirect_to action: :index
  end
end
