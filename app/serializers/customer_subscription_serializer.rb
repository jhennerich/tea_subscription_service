class CustomerSubscriptionSerializer
 include JSONAPI::Serializer
 belongs_to :customer
 belongs_to :tea

 def self.hashed_subscriptions(subscriptions)
     {
       "data": {
          "type": "subscriptions",
          "attributes": subscriptions.each do |subscription|
            {
              "title": subscription.title,
              "price": subscription.price,
              "frequency": subscription.frequency,
              "status": subscription.status
            }
        end
       }
     }
  end
end
