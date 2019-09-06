docker build -t pbernard/fibonacci-k8s-client:latest -t pbernard/fibonacci-k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t pbernard/fibonacci-k8s-server:latest -t pbernard/fibonacci-k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t pbernard/fibonacci-k8s-worker:latest -t pbernard/fibonacci-k8s-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pbernard/fibonacci-k8s-client:latest
docker push pbernard/fibonacci-k8s-server:latest
docker push pbernard/fibonacci-k8s-worker:latest

docker push pbernard/fibonacci-k8s-client:$SHA
docker push pbernard/fibonacci-k8s-server:$SHA
docker push pbernard/fibonacci-k8s-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pbernard/fibonacci-k8s-server:$SHA
kubectl set image deployments/client-deployment client=pbernard/fibonacci-k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=pbernard/fibonacci-k8s-worker:$SHA