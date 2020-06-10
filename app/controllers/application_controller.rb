# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale
  before_action :set_locale
  add_flash_types :success, :error

  def require_login
    unless logged_in?
      flash[:error] = t('users.should_login')
      redirect_to new_user_url
    end
  end

  private

  def set_locale
    locale = if current_user
               current_user.locale
             elsif params[:locale]
               session[:locale] = params[:locale]
             elsif session[:locale]
               session[:locale]
             else
               http_accept_language.compatible_language_from(I18n.available_locales)
             end
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
