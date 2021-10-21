docker build -t marcusmortera/multi-client:latest -t marcusmortera/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcusmortera/multi-server:latest -t marcusmortera/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcusmortera/multi-worker:latest -t marcusmortera/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcusmortera/multi-client:latest
docker push marcusmortera/multi-server:latest
docker push marcusmortera/multi-worker:latest

docker push marcusmortera/multi-client:$SHA
docker push marcusmortera/multi-server:$SHA
docker push marcusmortera/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=marcusmortera/multi-client:$SHA
kubectl set image deployments/server-deployment server=marcusmortera/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=marcusmortera/multi-worker:$SHA