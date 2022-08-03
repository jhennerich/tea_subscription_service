Subscription.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('subscriptions')
Tea.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('teas')
Customer.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('customers')

cust = Customer.create!(first_name: 'John', last_name: 'H', email: 'john@email.com', address: '123 Anywhere')
tea1 = Tea.create!(title: 'Earl Grey', description: 'Good stuff', temperature: 212, brew_time: 240)
tea2 = Tea.create!(title: 'English Breakfast', description: 'Good stuff in the morning', temperature: 212, brew_time: 240)
cust.subscriptions.create!( tea_id: tea1.id, title: 'John sub', price: 4, frequency: 0, status: 0)
cust.subscriptions.create!( tea_id: tea2.id, title: 'John sub', price: 4, frequency: 1, status: 1)
