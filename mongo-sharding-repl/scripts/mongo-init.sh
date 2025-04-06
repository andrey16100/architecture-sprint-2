#!/bin/bash

###
# Инициализируем сервер конфигурации
###

docker compose exec -T configSrv mongosh --port 27017 --quiet <<EOF
rs.initiate(
  {
    _id : "config_server",
    configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
EOF

sleep 10

###
# Инициализируем шарды
###

docker compose exec -T shard11 mongosh --port 27011 --quiet <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard11:27011" },
        { _id : 1, host : "shard12:27012" },
        { _id : 2, host : "shard13:27013" },
      ]
    }
);
EOF

docker compose exec -T shard21 mongosh --port 27021 --quiet <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 0, host : "shard21:27021" },
        { _id : 1, host : "shard22:27022" },
        { _id : 2, host : "shard23:27023" },
      ]
    }
);
EOF

###
# Инициализируем роутер и наполните его тестовыми данными
###

sleep 10

docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
sh.addShard( "shard1/shard11:27011");
sh.addShard( "shard2/shard21:27021");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )

use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})
EOF
