#kubectl apply -f elf.namespace.yaml
helm repo add elastic https://helm.elastic.co
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update
helm install elasticsearch elastic/elasticsearch --version=7.9.0 --namespace=logging --values toleration.yaml
helm install fluent-bit fluent/fluent-bit --namespace=logging --values toleration.yaml
helm install kibana elastic/kibana --version=7.9.0 --namespace=logging --set service.type=NodePort --values toleration.yaml
kubectl run random-logger --image=chentex/random-logger -n logging
#kubectl apply -f ingress.yaml -n logging

