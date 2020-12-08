# Stocks

First of all, I didn't make tests for all code. Only for POST create and all which is connected somehow with it (validators, serializer, sequence).
Other endpoints quite similar so right now it seems unnecessary. (Honestly, I still have 4 failing tests)
Rubocop also is not my target right now. 

About code. The main logic is laying in domains. The task for creating endpoints was abstract enough so I made it without any business logic or some.

Follow instructions to run the project:

Install gems:

```
bundle install
```

Create new database user with superuser role. Assign a password to new role (password: ruby):
```
createuser -dlsP ruby
```

Create database:
```
bundle exec rake db:create
```

Apply migration:
```
bundle exec rake db:migrate
```

```
RACK_ENV=test bundle exec rake db:migrate
```

#### Rake tasks

Start server at development mode:
```
bundle exec rake app:server
```

Run pry console

```
bundle exec rake app:console
```

### Tests

```
rspec
```

Create stock:

```
curl --request POST \
  --url localhost:5050/api/v1/stocks \
  --header 'content-type: application/json' \
  --data '{"data":{
        "id":"1",
        "type":"stocks",
        "attributes":{"bearer_id":"100","name":"Stock #1"}}
        }
```

Update stock (we can update whatever we want, but right now I just add opportunity to change bearer_id):

```
curl --request PUT \
  --url localhost:5050/api/v1/stocks \
  --header 'content-type: application/json' \
  --data '{"data":{
        "id":"1",
        "type":"stocks",
        "attributes":{"bearer_id":"101","name":"Stock #1"}}
}'
```

Get all stocks:
```
curl --request GET \
--url localhost:5050/api/v1/stocks \
```

Safe delete stocks:
```
curl --request DELETE \
  --url localhost:5050/api/v1/stocks/:1 \
```
