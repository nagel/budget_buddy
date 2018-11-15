class Api::UsersController < ApplicationController
  def index
    @users = User.all
    render "index.json.jbuilder"
  end

  def create
    @user = User.new({
      name: params[:name],
      email: params[:email]
    })
    @user.save

    render "show.json.jbuilder"
  end

  def show
    @user = User.find_by(id: params[:id])
    render "show.json.jbuilder"
  end

  def update
    @user = User.find_by(id: params[:id])

    @user.name = params[:name] || @user.name
    @user.email = params[:email] || @user.email

    @user.save

    render "show.json.jbuilder"
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy

    render json: {message: "Category deleted!"}
  end
end
