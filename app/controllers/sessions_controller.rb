# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    if login(params[:email], params[:password])
      redirect_to root_url, notice: t('enter_login')
    else
      flash.now.alert = I18n.t 'invalid_login'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: t('exit_login')
  end
end
