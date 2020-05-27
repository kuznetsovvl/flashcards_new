# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: t('.success')
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = t('.success')
      redirect_to root_path
    else
      flash.now[:error] = t('.error')
      render 'edit'
    end
  end

  def change_password
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :locale)
  end
end
