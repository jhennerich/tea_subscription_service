class Api::V1::SubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :check_for_errors

  def index
    customer = Customer.find(params[:customer_id])
    render json: CustomerSubscriptionSerializer.hashed_subscriptions(customer.subscriptions),
      status: :ok
  end

  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find_by!(title: params[:tea])

    subscription = customer.subscriptions.create(
      tea_id: tea.id,
      title: "#{customer.first_name}'s #{tea.title}",
      price: params[:price],
      frequency: params[:frequency],
      status: 'active'
    )
    render json: CustomerSubscriptionSerializer.hashed_subscriptions(customer.subscriptions),
      status: :ok
  end





  private

  def check_for_errors
    render json: { 'error': 'id not found' }, status: 404
  end
end
