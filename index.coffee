# async = require 'async'
lua_scripts = require('node-redis-lua') __dirname + "/lua/"

module.exports = (redis) ->

	lua_scripts redis

	getTaskMask = (tasks) ->
		outBuffer = new Buffer 0
		p = 0
		bits = 0
		for i in [0...tasks]
			p = p >> 1
			p = p | 128
			bits++
			if bits is 8
				bits = 0
				b = new Buffer 1
				b.writeUInt8 p, 0
				p = 0
				outBuffer = Buffer.concat [outBuffer, b]

		b = new Buffer 1
		b.writeUInt8 p, 0
		outBuffer = Buffer.concat [outBuffer, b]
		outBuffer


	# b = getTaskMask(2) #.toString 'hex'
	# console.log b
	redis.setsatisfy = (key, tasks, done) ->
		redis.set key, getTaskMask(tasks), (err) ->
			done err
	# r.set "mrdka", b, () ->
	# 	## todo TTL
	# 	r.satisfybit "mrdka", "result", 1, () ->
	# 		console.log arguments
	# 	r.satisfybit "mrdka", "result", 0, () ->
	# 		console.log arguments
	# 	return
