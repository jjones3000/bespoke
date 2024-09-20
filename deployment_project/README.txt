aws s3 mb s3://seqera-platform-terraform-state-bucket


aws eks --region <region> update-kubeconfig --name <eks-cluster-name>
kubectl get nodes

cd /path/to/deployment_project/kubernetes

kubectl apply -f nginx-deployment.yaml
kubectl apply -f backend-deployment.yaml

kubectl get pods
kubectl get svc

kubectl get svc nginx-service

Check the logs of the running pods for any issues
=================================================
kubectl logs <pod-name>

Verify that the Redis cache is working by inspecting the Redis pod/service:
===========================================================================
kubectl get svc redis-service


terraform destroy
