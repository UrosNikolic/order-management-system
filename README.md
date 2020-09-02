# Order management system

### Prerequesites
```
Ruby version - 2.6
Rails version - 6
Postgresql
```

### Setup

1. Create test and dev database
2. Copy .env.sample and create .env file and add variable values 
3. Run bundle install
4. Run migrations bundle exec rake db:migrate
5. Run server rails s

### Run tests

```
rails db:environment:set RAILS_ENV=test
bundle exec rspec
```

### Routes

```
Products

GET /products  
POST /products  
GET /products/:id  
PUT /products/:id  
DELETE /products/:id

Orders

GET /orders  
POST /orders  
GET /orders/:id  
PUT /orders/:id

Status Transitions

GET /orders/:id/status_transitions  
POST /orders/:id/status_transitions

Line Items
GET /orders/:id/line_items  
POST /orders/:id/line_items  
GET /orders/:id/line_items/:id  
PUT /orders/:id/line_items/:id  
DELETE /orders/:id/line_items/:id
```




