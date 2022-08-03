# README

### GET: /api/v1/customers/1/subscriptions
- expected JSON
```
{
    "data": {
        "type": "subscriptions",
        "attributes": [
            {
                "id": 1,
                "tea_id": 1,
                "customer_id": 1,
                "title": "John sub",
                "price": 4,
                "status": "cancelled",
                "frequency": "weekly",
                "created_at": "2022-08-02T20:32:36.534Z",
                "updated_at": "2022-08-02T20:32:36.534Z"
            },
            {
                "id": 2,
                "tea_id": 2,
                "customer_id": 1,
                "title": "John sub",
                "price": 4,
                "status": "active",
                "frequency": "monthly",
                "created_at": "2022-08-02T20:32:36.535Z",
                "updated_at": "2022-08-02T20:32:36.535Z"
            }
        ]
    }
}
```
### POST: /api/v1/customers/1/subscriptions
- JSON body
```
{

        "tea" : "Earl Grey",
        "price" : 500,
        "frequency" : "monthly",
        "status" : "active"
}
```
- expected JSON response
```
{
    "data": {
        "type": "subscriptions",
        "attributes": [
            {
                "id": 1,
                "tea_id": 1,
                "customer_id": 1,
                "title": "John sub",
                "price": 4,
                "status": "active",
                "frequency": "weekly",
                "created_at": "2022-08-02T20:32:36.534Z",
                "updated_at": "2022-08-02T20:32:36.534Z"
            }
          ]
    }
}
```
