# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    if login(resource_params[:email], resource_params[:password])
      redirect_to root_url, notice: t('.success')
    else
      flash.now.alert = t('.error')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: t('.success')
  end

  private

  def resource_params
    params.require(:login).permit(:email, :password)
  end
end
