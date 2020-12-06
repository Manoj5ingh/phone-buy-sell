require 'rails_helper'

RSpec.describe "AdminController", :type => :request do

  before(:each) do
    user = "admin"
    password = "admin"
    @authorization_header = "Basic #{Base64.encode64("#{user}:#{password}").strip}"
  end

  before(:all) do
    Cart.delete_all
    Product.delete_all
    @product = Product.new
    @product.save!
  end

  context 'Admin routes' do
    it 'should return list of products' do
      get '/v1/admin/products', headers: {'Authorization' => @authorization_header}
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result["data"].count).to eq 1
    end

    it 'should return product with p_id' do
      get "/v1/admin/product/#{@product.id}", headers: {'Authorization' => @authorization_header}
      expect(response.status).to eq 200
    end

    it 'should delete product with p_id' do
      delete "/v1/admin/remove_product/#{@product.id}", headers: {'Authorization' => @authorization_header}
      expect(response.status).to eq 200
    end

    it 'should update product' do
      params = {}
      params[:condition] = "In good condition display working fine"
      put "/v1/admin/edit_product/#{@product.id}", headers: {'Authorization' => @authorization_header}, params: params
      expect(response.status).to eq 200
    end    
  end
end