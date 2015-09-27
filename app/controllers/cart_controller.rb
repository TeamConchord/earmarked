class CartController < ApplicationController

  def show
    @donations = session[:donations]
  end

  def update
    donation = cart.update(params)
    if donation.values.pop.to_i < 0
      flash[:notice] = "Donation must be greater than 0. Please try again!"
    else
      session[:donations] = session[:donations].merge(cart.update(params))
    end
    redirect_to cart_path
  end

  def destroy
    session[:donations][params[:id]] = nil
    redirect_to cart_path
  end
end