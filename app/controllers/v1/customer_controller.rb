require "error/common"
module V1
  class CustomerController < ApplicationController
    include Error::Common
    before_action :authenticate
    
    def products
      products = Product.all
      render :json=> {data: products}.to_json, :status => 200
    end

    def product
      products = Product.find(params[:id])
      render :json=> {data: products}.to_json, :status => 200
    end

    def add_to_cart
      cart = Cart.new
      cart.unit = params[:units]
      cart.product_id = params[:product_id]
      cart.user_id =   current_user.id
      cart.save
      render :json => {data: cart}.to_json, :status => 200
    end

    def show_cart
      cart_data = Cart.select('*').where(:user_id =>   current_user.id) 
      render :json=> {data: cart_data}.to_json, :status => 200
    end

    def buys
      address_id = params[:address_id]
      user_id = current_user.id
      cart_data = Cart.select('*').where(:user_id => user_id)
      order_tracker = get_tracker(user_id)
      carts_to_orders(cart_data, order_tracker.id, address_id)
      set_success_msg(order_tracker)
      render :json=> "order placed successfully, Tracking id for reference is #{order_tracker.id}", :status => 200
    end

    def buy_with_pid
      address_id = params[:address_id]
      user_id = current_user.id
      order_tracker = get_tracker(user_id)
      save_order(order_tracker.id, address_id)
      set_success_msg(order_tracker)
      render :json=> "order placed successfully, Tracking id for reference is #{order_tracker.id}", :status => 200
    end

    def get_track
      tracker = Tracking.find(params[:tracking_id])
      render :json=> {data: tracker}.to_json, :status => 200
    end

    private
    def authenticate
      render_error(SecurityError.new) unless authorized_user?
    end

    def get_tracker(user_id)
      order_tracker = Tracking.new
      order_tracker.user_id = user_id
      order_tracker.save!
      return order_tracker
    end
    
    def set_success_msg(order_tracker)
      order_tracker.status = 'Ordered'
      order_tracker.message = 'Successfully Ordered'
      order_tracker.save!
    end

    def save_order(tracker_id, address_id)
      order = Order.new
      order.tracking_id = tracker_id
      order.delivery_address_id = address_id
      order.product_id = params[:pid]
      order.units = params[:units]
      order.status = 'Ordered'
      order.message = 'Order successfully placed'
      order.save!
    end

    def carts_to_orders(cart_data, tracking_id, address_id)
      cart_data.each do |cart|
        order = Order.new
        order.tracking_id = tracking_id
        order.delivery_address_id = address_id
        order.product_id = cart.product_id
        order.units = cart.unit
        order.status = 'Ordered'
        order.message = 'Order successfully placed'
        order.save! # We can do it in bulk also but due to time constraint going with one by one
      end
    end
  end
end