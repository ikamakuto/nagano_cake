class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order=Order.new
    @credit_card=Order.payment_methods.key(0)
    @transfer=Order.payment_methods.key(1)
    @credit_card_ja=Order.payment_methods_il8n[:credit_card]
    @transfer_ja=Order.payment_methods_il8n[:transfer]
  end

  def index
    @order=current_customer.orders
  end

  def show
    if params[:id] == "confirm"
      redirect_to new_order_path
    else
      @order = Order.find(params[:id])
    end
  end

  def confirm
    @order = Order.new(order_params)
    @order.shipping_cost=800
    @total_prayment_except_fee = current_customer.cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_prayment = @total_prayment_except_fee + @order.shipping_fee

    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name == current_customer.full_name

    elsif 
      @shipping = Shipping.find(params[:order][:shipping_id])
      @order.postal_code = @shipping.postal_code
      @order.address = @shipping.address
      @order.name == @shipping.name
    else
      redirect_to request.referer
    end
  end
  
  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    if order.save
      current_customer.cart_items.each do | cart_item |
      end
    end
  end
end
