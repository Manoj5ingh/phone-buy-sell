module V1
  class AdminController < ApplicationController
    def products
      products = Product.all
      render :json=> {data: products}.to_json, :status => 200
    end

  end
end