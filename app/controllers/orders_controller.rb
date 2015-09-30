class OrdersController < ApplicationController

  def create
    if current_user

      order = Order.create(user_id: current_user.id, total: cart.total)

      cart.donations.each do |donation|
        donation.order_id = order.id
        donation.user_id  = current_user.id
        donation.save
      end
      session[:donations].clear
      if current_user.phone_number == true
        SendNotification.new.text_message(current_user.phone_number)
      end
      redirect_to order_path(order)
    else
      flash[:errors] = "Please sign in to donate!"
      redirect_to cart_path
    end
  end

  def show
    @order = Order.find(params["id"])
    @donations = Donation.where(order_id: @order.id)
    
  end
end
