# Set the global varible to access redis
$redis = Redis::Namespace.new(MyXandO.to_s, :redis => Redis.new)
