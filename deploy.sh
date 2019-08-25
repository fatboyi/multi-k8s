docker build -t skytower/multi-client:latest -t skytower/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skytower/multi-server:latest -t skytower/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skytower/multi-worker:latest -t skytower/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push skytower/multi-client:latest
docker push skytower/multi-server:latest
docker push skytower/multi-worker:latest

docker push skytower/multi-client:$SHA
docker push skytower/multi-server:$SHA
docker push skytower/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skytower/multi-server:$SHA
kubectl set image deployments/client-deployment client=skytower/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skytower/multi-worker:$SHA