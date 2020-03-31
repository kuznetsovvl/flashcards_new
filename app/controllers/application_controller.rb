# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def require_login
    unless logged_in?
      flash[:error] = I18n.t 'reg_users.should_login'
      redirect_to new_user_url
    end
  end
end
