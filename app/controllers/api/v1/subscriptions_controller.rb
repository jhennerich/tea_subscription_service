class Api::V1::SubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :check_for_errors
#  rescue_from ActiveRecord::RecordInvalid, with: :render_400

  def index
    customer = Customer.find(params[:customer_id])
    render json: CustomerSubscriptionSerializer.hashed_subscriptions(customer.subscriptions),
      status: :ok
  end

  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find_by(title: params[:tea])
    sub_title = "#{customer.first_name}'s #{tea.title}"
    params[:subscription][:tea_id] = tea.id
    params[:subscription][:title] = "#{customer.first_name}'s #{tea.title}"

    begin
      subscription = customer.subscriptions.create!(sub_params)
    rescue ActiveRecord::RecordInvalid
       render json: { 'error': 'Missing parameters'}, status: :bad_request
       return
    end

    render json: CustomerSubscriptionSerializer.show(subscription), status: :ok
  end


  def update
    subscription = Subscription.find(params[:id])
    subscription.update(sub_params)
    render json: CustomerSubscriptionSerializer.show(subscription), status: :ok
  end

  def cancel
    subscription = Subscription.find(params[:id])
    subscription.status = 'cancelled'
    subscription.save
    render json: CustomerSubscriptionSerializer.show(subscription), status: :ok
  end

  private

    def sub_params
      params.require(:subscription).permit(:tea_id, :title, :price, :frequency, :status )
    end

    def check_for_errors
      render json: { 'error': 'id not found' }, status: 404
    end
end
