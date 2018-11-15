class Api::CategoriesController < ApplicationController

  def index
    @categories = Category.all
    render "index.json.jbuilder"
  end

  def create
    @category = Category.new({
      category_name: params[:category_name],
      user_id: params[:user_id]
    })
    @category.save

    render "show.json.jbuilder"
  end

  def show
    @category = Category.find_by(id: params[:id])
    render "show.json.jbuilder"
  end

  def update
    @category = Category.find_by(id: params[:id])

    @category.category_name = params[:category_name] || @catogery.category_name
    @category.user_id = params[:user_id] || @category.user_id

    @category.save

    render "show.json.jbuilder"
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    @category.destroy

    render json: {message: "Category deleted!"}
  end

end
