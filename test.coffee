redis =
bisatisfy = require './'

redis = (require 'redis').createClient()
redis.on 'error', (err) -> console.log err

bisatisfy redis

redis.setsatisfy "mrdka", 3, (err) ->
	console.log arguments
	setTimeout () ->
		redis.satisfybit "mrdka", "result", 1, (err, res) -> console.log arguments
	, 500
	setTimeout () ->
		redis.satisfybit "mrdka", "result", 2, (err, res) -> console.log arguments
	, 500
	setTimeout () ->
		redis.satisfybit "mrdka", "result", 0, (err, res) -> console.log arguments
	, 100

	# if res is 0 then satisfied and pushed to result