class Api::VendorsController < ApplicationController

  def index
    @vendors = Vendor.all
    render "index.json.jbuilder"
  end

  def create
    @vendor = Vendor.new({
      vendor_name: params[:vendor_name],
      category_id: params[:category_id]
    })
    @vendor.save

    render "show.json.jbuilder"
  end

  def show
    @vendor = Vendor.find_by(id: params[:id])
    render "show.json.jbuilder"
  end

  def update
    @vendor = Vendor.find_by(id: params[:id])

    @vendor.vendor_name = params[:vendor_name] || @vendor.vendor_name
    @vendor.category_id = params[:category_id] || @vendor.category_id

    @vendor.save

    render "show.json.jbuilder"
  end

  def destroy
    @vendor = Vendor.find_by(id: params[:id])
    @vendor.destroy

    render json: {message: "Vendor deleted!"}
  end

end
