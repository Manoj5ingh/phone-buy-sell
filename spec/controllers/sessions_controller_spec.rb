require 'rails_helper'

RSpec.describe SessionController, type: :controller do

  before(:all) do
    if User.find_by(username: 'testid').nil?
      new_user = User.new
      new_user.username = 'testid'
      new_user.password = 'test123'
      new_user.email = 'dummy@email.com'
      new_user.save!
    end
  end

  context 'to verify credentials' do
    it 'should return error as username given is wrong' do
      @params = {
        :user => {
          :username => 'wrongusername',
          :password => 'test123'
        }
      }
      post :create, :params => @params
      result = JSON.parse(response.body)
      expect(result["status"]).to eq 401
      expect(result["errors"][0]).to eq ("Invalid credentials. Please try again")
    end
  
    it 'should return error as password given is wrong' do
      @params = {
        :user => {
          :username => 'testid',
          :password => 'wrongpassword'
        }
      }
      post :create, :params => @params
      result = JSON.parse(response.body)
      expect(result["status"]).to eq 401
      expect(result["errors"][0]).to eq ("Invalid credentials. Please try again")
    end

    it 'should return 200 status code' do
      @params = {
        :user => {
          :username => 'testid',
          :password => 'test123'
        }
      }
      post :create, :params => @params
      expect(response.status).to eq 200
    end
  end

  context 'to check if user is logged in or not' do
    it 'should return no user as no login can be found' do
      @params = {
        :user => {
          :username => 'testid',
          :password => 'wrongpassword'
        }
      }
      get :is_logged_in?, :params => @params
      result = JSON.parse(response.body)
      expect(result["logged_in"]).to eq false
      expect(result["message"]).to eq ("no such user")
    end
  end

end