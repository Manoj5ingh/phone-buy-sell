module V1
  class AdminController < ApplicationController
    before_action :authenticate
    def products
      products = Product.all
      render :json=> {data: products}.to_json, :status => 200
    end

    def product
      products = Product.find(params[:id])
      render :json=> {data: products}.to_json, :status => 200
    end

    def remove_product
      Product.delete(params[:id])
      render :json=> {data: "success"}.to_json, :status => 200      
    end

    def edit_product
      p_id = params[:id]
      product = Product.find(p_id)
      product.manufacturer = params[:manufacturer] if params[:manufacturer].nil?
      product.storage_size = params[:storage_size] if params[:storage_size].nil?
      product.model = params[:model] if params[:model].nil?
      product.colour = params[:colour] if params[:colour].nil?
      product.actual_price = params[:actual_price] if params[:actual_price].nil?
      product.units = params[:units] if params[:units].nil?
      product.selling_price = params[:selling_price] if params[:selling_price].nil?
      product.buying_price = params[:buying_price] if params[:buying_price].nil?
      product.condition = params[:condition] if params[:condition].nil?
      product.save!
      render :json=> {data: product}.to_json, :status => 200            
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == "admin"
      end
    end
  end
end