redis.call('setbit',KEYS[1], ARGV[1], 0)
if redis.call('bitpos', KEYS[1], 1) == -1 then
	redis.call('rpush', KEYS[2], KEYS[1])
	redis.call('del', KEYS[1])
	return 0
else
	return -1
end