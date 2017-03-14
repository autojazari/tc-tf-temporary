# Redis ElastiCache

resource "aws_elasticache_cluster" "test_content_redis" {
    cluster_id = "test-content-redis"
    engine = "redis"
    node_type = "cache.t2.micro"
    port = 11211
    num_cache_nodes = 1
    parameter_group_name = "default.redis3.2"
}
