docker build -t rickopsourced/multi-client:latest -t rickopsourced/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rickopsourced/multi-server:latest -t rickopsourced/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rickopsourced/multi-worker:latest -t rickopsourced/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t rickopsourced/apache:latest -t rickopsourced/apache:$SHA -f ./apache/Dockerfile ./apache

docker push rickopsourced/multi-client:latest
docker push rickopsourced/multi-server:latest
docker push rickopsourced/multi-worker:latest
docker push rickopsourced/apache:latest

docker push rickopsourced/multi-client:$SHA
docker push rickopsourced/multi-server:$SHA
docker push rickopsourced/multi-worker:$SHA
docker push rickopsourced/apache:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rickopsourced/multi-server:$SHA
kubectl set image deployments/client-deployment client=rickopsourced/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rickopsourced/multi-worker:$SHA
kubectl set image deployments/apache-deployment worker=rickopsourced/apache:$SHA
