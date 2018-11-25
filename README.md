# API with Ruby on Rails

> 🛤 Sample API with Ruby on Rails, following [Katapi](https://github.com/octo-woapi/katapi) contract.

## Status

Runnable - You can find a live example here: https://octo-woapi-rails.herokuapp.com/api/v1/products

## Getting started

Install [rvm](https://rvm.io/)

Use the relevant Ruby version
```
$ rvm use ruby-2.5.3
```

Install bundler
```
$ gem install bundler
```

Install other dependencies
```
$ bundle
```

Copy database file and fill it with your database settings
```
$ cp config/database.yml.example config/database.yml
```

Create and migrate database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the tests
```
$ rake
```

Start the project
```
$ rails s # default port is 3000
```

## Features

You can only GET /products for now, provided you have some in the database. :)

### Products

#### GET /products

```json
[
    {
        "id": 1,
        "name": "Nintendo Switch",
        "price": 300,
        "weight": 3,
        "createdAt": "2018-04-06T13:21:32.611Z",
        "updatedAt": "2018-04-06T13:21:32.611Z"
    }
]
```

#### GET /products/1

```json
{
    "id": 1,
    "name": "Nintendo Switch",
    "price": 300,
    "weight": 3,
    "createdAt": "2018-04-06T13:21:32.611Z",
    "updatedAt": "2018-04-06T13:21:32.611Z"
}
```

#### POST /products

```json
{
    "name": "Nintendo Switch",
    "price": 300,
    "weight": 3
}
```

#### PUT /products/1

```json
{
    "name": "Nintendo Switch",
    "price": 300,
    "weight": 3,
}
```

#### DELETE /products/1

### Orders

#### GET /orders

```json
[
    {
        "id": 1,
        "shipment_amount": 10,
        "total_amount": 300,
        "weight": 28,
        "status": "pending",
        "products": [
            {
                "id": 2,
                "quantity": 3
            }
        ],
        "createdAt": "2018-04-06T13:21:32.611Z",
        "updatedAt": "2018-04-06T13:21:32.611Z"
    }
]
```

#### GET /orders/1

```json
{
    "id": 1,
    "shipment_amount": 10,
    "total_amount": 300,
    "weight": 28,
    "status": "pending",
    "products": [
        {
            "id": 2,
            "quantity": 3
        }
    ],
    "createdAt": "2018-04-06T13:21:32.611Z",
    "updatedAt": "2018-04-06T13:21:32.611Z"
}
```

#### POST /orders

```json
{
    "products": [
        {
            "id": 3,
            "quantity": 1
        }
    ]
}
```

#### PUT /orders/1

```json
{
    "status": "paid",
    "products": [
        {
            "id": 3,
            "quantity": 1
        }
    ]
}
```

#### DELETE /orders/1

### Bills

#### GET /bills

```json
[
    {
        "id": 1,
        "amount": 250,
        "createdAt": "2018-04-06T13:21:32.611Z",
        "updatedAt": "2018-04-06T13:21:32.611Z"
    }
]
```

#### GET /bills/1

```json
{
    "id": 1,
    "amount": 250,
    "createdAt": "2018-04-06T13:21:32.611Z",
    "updatedAt": "2018-04-06T13:21:32.611Z"
}
```
