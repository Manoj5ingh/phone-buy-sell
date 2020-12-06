require 'rails_helper'

RSpec.describe "CustomerController", :type => :request do

  before(:all) do
    @user = User.find_by(username: 'testid')
    if @user.nil?
      @user = User.new
      @user.username = 'testid'
      @user.password = 'test123'
      @user.email = 'dummy@email.com'
      @user.save!
    end
    Cart.delete_all
    Product.delete_all
    Address.delete_all 
    @address = Address.new
    @address.save!
    @product = Product.new
    @product.save!
    cart = Cart.new
    cart.product_id = @product.id
    cart.unit = 2
    cart.user_id = @user.id
    cart.save!
    @params = {
        :user => {
          :username => 'wrongusername',
          :password => 'test123'
        }
      }
  end
  
  context 'Customer routes' do
    it 'should return list of cart items' do
      expect_any_instance_of(ApplicationController).to receive(:authorized_user?).and_return('')
      expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      get '/v1/customer/show_cart'
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result["data"].count).to eq 1
    end

    it 'should return list of products' do
      expect_any_instance_of(ApplicationController).to receive(:authorized_user?).and_return('')
      get '/v1/customer/products'
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result["data"].count).to eq 1
    end

    it 'should return product with p_id' do
      expect_any_instance_of(ApplicationController).to receive(:authorized_user?).and_return('')
      get "/v1/customer/product/#{@product.id}"
      expect(response.status).to eq 200
    end

    it 'should add to card' do
      params = {}
      params["units"] = 2
      params["product_id"] = @product.id
      expect_any_instance_of(ApplicationController).to receive(:authorized_user?).and_return('')
      expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      post "/v1/customer/add_to_cart", params: params
      expect(response.status).to eq 200
    end

    it 'should add buying data to orders' do
      params = {}
      params[:address_id] = @address.id
      expect_any_instance_of(ApplicationController).to receive(:authorized_user?).and_return('')
      expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      post "/v1/customer/buy", params: params
      expect(response.status).to eq 200
    end

    it 'should buy with p_id' do
      params = {}
      params[:address_id] = @address.id
      expect_any_instance_of(ApplicationController).to receive(:authorized_user?).and_return('')
      expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      post "/v1/customer/buy/#{@product.id}", params: params
      expect(response.status).to eq 200
    end

    it 'get status using tracking id' do
      tracker = Tracking.new
      tracker.user_id = @user.id
      tracker.save!
      expect_any_instance_of(ApplicationController).to receive(:authorized_user?).and_return('')
      get "/v1/customer/track/#{Tracking.first.id}"
      expect(response.status).to eq 200
    end

  end
end