require 'rails_helper'

RSpec.describe 'POST/subscribe API endpoint' do
  context 'happy path' do
    it 'creates a customer tea subscription' do
      cust = Customer.create!(first_name: 'John', last_name: 'H', email: 'john@email.com', address: '123 Anywhere')
      tea1 = Tea.create!(title: 'Earl Grey', description: 'Good stuff', temperature: 212, brew_time: 240)

      subscription_params = {
        customer_id: cust.id,
        tea: tea1.title,
        price: 500,
        frequency: 'monthly'
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{cust.id}/subscriptions", headers: headers,
        params: JSON.generate(subscription_params)

      response_body = JSON.parse(response.body, symbolize_names: true)
      subs = response_body[:data]

      expect(response).to be_successful
      expect(response).to have_http_status 200
      expect(subs).to be_a Hash

      expect(subs.count).to eq 2
      sub_attributes = subs[:attributes]

      expect(sub_attributes).to have_key :id
      expect(sub_attributes[:id]).to be_a Integer
      expect(sub_attributes).to have_key :title
      expect(sub_attributes[:title]).to be_a String
      expect(sub_attributes).to have_key :price
      expect(sub_attributes[:price]).to be_a Integer
      expect(sub_attributes).to have_key :status
      expect(sub_attributes[:status]).to be_a String
      expect(sub_attributes).to have_key :frequency
      expect(sub_attributes[:frequency]).to be_a String
    end
  end
  context 'sad path' do
    it 'invalid customer id returns 404' do

      tea1 = Tea.create!(title: 'Earl Grey', description: 'Good stuff', temperature: 212, brew_time: 240)

      subscription_params = {
#        customer_id: cust.id,
        tea: tea1.title,
        price: 500,
        frequency: 'monthly'
      }

      post "/api/v1/customers/1000/subscriptions", headers: headers,
        params: JSON.generate(subscription_params)

      expect(response).to_not be_successful
      expect(response).to have_http_status 404

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq 'id not found'
    end
  end
end
