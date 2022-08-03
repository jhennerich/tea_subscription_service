require 'rails_helper'

RSpec.describe 'Cancel subscription API endpoint' do
  context 'happy path' do
    it 'cancels a subscriptions' do
      cust = Customer.create!(first_name: 'John', last_name: 'H', email: 'john@email.com', address: '123 Anywhere')
      tea1 = Tea.create!(title: 'Earl Grey', description: 'Good stuff', temperature: 212, brew_time: 240)
      tea2 = Tea.create!(title: 'English Breakfast', description: 'Good stuff in the morning', temperature: 212, brew_time: 240)
      sub = cust.subscriptions.create!( tea_id: tea1.id, title: 'John sub', price: 4, frequency: 1, status: 1)

      expect(sub.status).to eq('active')

      patch "/api/v1/customers/#{cust.id}/subscriptions/#{sub.id}"

      response_body = JSON.parse(response.body, symbolize_names: true)
      subs = response_body[:data]
      expect(response).to be_successful
      expect(response).to have_http_status 200

      expect(response_body).to have_key :data
      expect(subs).to be_a Hash
      expect(subs.count).to eq 2
      expect(subs[:attributes][:status]).to eq('cancelled')

    end
  end
  context 'sad path' do
    it 'returns 404 is the customer id is invalid' do
      cust = Customer.create!(first_name: 'John', last_name: 'H', email: 'john@email.com', address: '123 Anywhere')
      get '/api/v1/customers/1000/subscriptions'

      expect(response).to_not be_successful
      expect(response).to have_http_status 404

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key :error
      expect(response_body[:error]).to eq 'id not found'
    end
  end
end
