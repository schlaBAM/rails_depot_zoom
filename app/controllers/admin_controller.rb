# frozen_string_literal: true
class AdminController < ApplicationController
  def index
    @current_user = User.find_by(id: session[:user_id])
    @total_orders = Order.count
  end
end
