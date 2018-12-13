class Api::PlaidCategoriesController < ApplicationController

  def index
  end

  def create
  end

  def show
  end

  def update

    @plaid_category = PlaidCategory.find_by(id: params[:id])

    @plaid_category.plaid_category_API_ID = params[:plaid_category_API_ID] || @plaid_category.plaid_category_API_ID
    @plaid_category.plaid_category_name = params[:plaid_category_name] || @plaid_category.plaid_category_name
    @plaid_category.category_id = params[:category_id] || @plaid_category.category_id

    render "show.json.jbuilder"
  end

  def destroy
  end

end
