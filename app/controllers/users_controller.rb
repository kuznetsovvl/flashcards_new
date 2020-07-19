# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, except: %i[new create]

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, success: t('.success')
    else
      render 'edit', error: t('.error')
    end
  end

  def edit_password; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :locale)
  end
end
