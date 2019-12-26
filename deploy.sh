docker build -t cab1729/multi-client:latest -t cab1729/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cab1729/multi-server:latest -t cab1729/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cab1729/multi-worker:latest -t cab1729/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push cab1729/multi-client:latest
docker push cab1729/multi-server:latest
docker push cab1729/multi-worker:latest
docker push cab1729/multi-client:$SHA
docker push cab1729/multi-server:$SHA
docker push cab1729/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cab1729/multi-server:$SHA
kubectl set image deployments/client-deployment client=cab1729/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cab1729/multi-worker:$SHA