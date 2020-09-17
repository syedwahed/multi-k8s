docker build -t syedwahed/multi-client:latest -t syedwahed/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t syedwahed/multi-server:latest -t syedwahed/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t syedwahed/multi-worker:latest -t syedwahed/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push syedwahed/multi-client:latest
docker push syedwahed/multi-server:latest
docker push syedwahed/multi-worker:latest
docker push syedwahed/multi-client:$SHA
docker push syedwahed/multi-server:$SHA
docker push syedwahed/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=syedwahed/multi-server:$SHA
kubectl set image deployments/client-deployment client=syedwahed/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=syedwahed/multi-worker:$SHA