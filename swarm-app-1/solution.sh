docker swarm init
docker network create -d overlay frontend
docker network create -d overlay backend
docker service create --network frontend --name vote -p 80:80 --replicas 3 bretfisher/examplevotingapp_vote
docker service create --network frontend --name redis redis:3.2
docker service create --name worker --network frontend --network backend bretfisher/examplevotingapp_worker:java
docker service create --mount type=volume,source=db-data,target=/var/lib/postgresql/data --name db --network postgres:9.4
docker service create --name result -p 5001:80 --network backend bretfisher/examplevotingapp_result