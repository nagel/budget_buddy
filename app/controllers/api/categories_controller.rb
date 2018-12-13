class Api::CategoriesController < ApplicationController

  def index
    @categories = Category.where(user_id: current_user.id)
    render "index.json.jbuilder"
  end

  def create
    @category = Category.new({
      category_name: params[:category_name],
      user_id: current_user.id,
      budget_limit: params[:budget_limit]
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

    @category.category_name = params[:category_name] || @category.category_name
    @category.user_id = params[:user_id] || @category.user_id
    @category.budget_limit = params[:budget_limit] || @category.budget_limit

    @category.save

    render "show.json.jbuilder"
  end

  def destroy
    @category = Category.find_by(id: params[:id])

    # Updates all transaction category IDs to null for the category being deleted. 
    @category.transactions.update_all(category_id: nil)
    @category.destroy

    render json: {message: "Category deleted!"}
  end

end
