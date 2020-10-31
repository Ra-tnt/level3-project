all-test: shipping-test carts-test catalogue-test orders-test users-test payment-test frontend-test

shipping-test: ship test delete-test

carts-test: carts test delete-test

catalogue-test: catalogues test delete-test

orders-test: order test delete-test

users-test: users test delete-test

payment-test: payments test delete-test

frontend-test: frontend test delete-test

release:
	kubectl apply -f pipeline.yaml -f pipelineRun.yaml -n test
	tkn pipelinerun logs --last -f -n test

test:
	kubectl apply -f e2e-js-test/tekton-tasks/docker/task.yaml -f e2e-js-test/tekton-tasks/deploy/task.yaml -f e2e-js-test/Pipeline.yaml -f e2e-js-test/PipelineRun.yaml -n test


test-delete:
	kubectl delete -f e2e-js-test/tekton-tasks/docker/task.yaml -f e2e-js-test/tekton-tasks/deploy/task.yaml -f e2e-js-test/Pipeline.yaml -f e2e-js-test/PipelineRun.yaml -n test


serviceAccount:
	kubectl apply -f secrets.yaml -f serviceAccount.yaml -f clusterRole.yaml -f roleBinding.yaml -n test

ship:
	kubectl apply -f shipping/tekton-tasks/docker/task.yaml -f shipping/tekton-tasks/deploy/shipping-deploy.yaml -f shipping/tekton-tasks/deploy/shipping-svc.yaml -f shipping/Pipeline.yaml -f shipping/PipelineRun.yaml -n test


ship-delete:
	kubectl delete -f shipping/tekton-tasks/docker/task.yaml -f shipping/tekton-tasks/deploy/shipping-deploy.yaml -f shipping/tekton-tasks/deploy/shipping-svc.yaml -f shipping/Pipeline.yaml -f shipping/PipelineRun.yaml -n test



cart:
	kubectl apply -f carts/tekton-tasks/docker/task.yaml -f carts/tekton-tasks/deploy/carts-deploy.yaml -f carts/tekton-tasks/deploy/carts-svc.yaml -f carts/tekton-tasks/deploy/cartsdb-deploy.yaml -f carts/tekton-tasks/deploy/cartsdb-svc.yaml -f carts/Pipeline.yaml -f carts/PipelineRun.yaml -n test


cart-delete:
	kubectl delete -f carts/tekton-tasks/docker/task.yaml -f carts/tekton-tasks/deploy/carts-deploy.yaml -f carts/tekton-tasks/deploy/carts-svc.yaml -f carts/tekton-tasks/deploy/cartsdb-deploy.yaml -f carts/tekton-tasks/deploy/cartsdb-svc.yaml -f carts/Pipeline.yaml -f carts/PipelineRun.yaml -n test



catalogues:
	kubectl apply -f catalogue/tekton-tasks/docker/taskdb.yaml -f catalogue/tekton-tasks/docker/task.yaml -f catalogue/tekton-tasks/deploy/cataloguedb-deploy.yaml -f catalogue/tekton-tasks/deploy/cataloguedb-svc.yaml -f catalogue/tekton-tasks/deploy/catalogue-deploy.yaml -f catalogue/tekton-tasks/deploy/catalogue-svc.yaml -f catalogue/Pipeline.yaml -f catalogue/PipelineRun.yaml -n test


catalogues-delete:
	kubectl delete -f catalogue/tekton-tasks/docker/taskdb.yaml -f catalogue/tekton-tasks/docker/task.yaml -f catalogue/tekton-tasks/deploy/cataloguedb-deploy.yaml -f catalogue/tekton-tasks/deploy/cataloguedb-svc.yaml -f catalogue/tekton-tasks/deploy/catalogue-deploy.yaml -f catalogue/tekton-tasks/deploy/catalogue-svc.yaml -f catalogue/Pipeline.yaml -f catalogue/PipelineRun.yaml -n test


order:
	kubectl apply -f orders/tekton-tasks/docker/task.yaml -f orders/tekton-tasks/deploy/orders-deploy.yaml -f orders/tekton-tasks/deploy/orders-svc.yaml -f orders/tekton-tasks/deploy/ordersdb-deploy.yaml -f orders/tekton-tasks/deploy/ordersdb-svc.yaml -f orders/Pipeline.yaml -f orders/PipelineRun.yaml -n test


order-delete:
	kubectl delete -f orders/tekton-tasks/docker/task.yaml -f orders/tekton-tasks/deploy/orders-deploy.yaml -f orders/tekton-tasks/deploy/orders-svc.yaml -f orders/tekton-tasks/deploy/ordersdb-deploy.yaml -f orders/tekton-tasks/deploy/ordersdb-svc.yaml -f orders/Pipeline.yaml -f orders/PipelineRun.yaml -n test


users:
	kubectl apply -f user/tekton-tasks/docker/taskdb.yaml -f user/tekton-tasks/docker/task.yaml -f user/tekton-tasks/deploy/userdb-deploy.yaml -f user/tekton-tasks/deploy/userdb-svc.yaml -f user/tekton-tasks/deploy/user-deploy.yaml -f user/tekton-tasks/deploy/user-svc.yaml -f user/Pipeline.yaml -f user/PipelineRun.yaml -n test

users-delete:
	kubectl delete -f user/tekton-tasks/docker/taskdb.yaml -f user/tekton-tasks/docker/task.yaml -f user/tekton-tasks/deploy/userdb-deploy.yaml -f user/tekton-tasks/deploy/userdb-svc.yaml -f user/tekton-tasks/deploy/user-deploy.yaml -f user/tekton-tasks/deploy/user-svc.yaml -f user/Pipeline.yaml -f user/PipelineRun.yaml -n test


payments:
	kubectl apply -f payment/tekton-tasks/docker/task.yaml -f payment/tekton-tasks/deploy/payment-deploy.yaml -f payment/tekton-tasks/deploy/payment-svc.yaml -f payment/Pipeline.yaml -f payment/PipelineRun.yaml -n test

payments-delete:
	kubectl delete -f payment/tekton-tasks/docker/task.yaml -f payment/tekton-tasks/deploy/payment-deploy.yaml -f payment/tekton-tasks/deploy/payment-svc.yaml -f payment/Pipeline.yaml -f payment/PipelineRun.yaml -n test

frontend:
	kubectl apply -f front-end/tekton-tasks/docker/task.yaml -f front-end/tekton-tasks/deploy/ingresstask.yaml -f front-end/tekton-tasks/deploy/frontend-deploy.yaml -f front-end/tekton-tasks/deploy/frontend-svc.yaml -f front-end/Pipeline.yaml -f front-end/PipelineRun.yaml -n test

frontend-delete:
	kubectl delete -f front-end/tekton-tasks/docker/task.yaml -f front-end/tekton-tasks/deploy/ingresstask.yaml -f front-end/tekton-tasks/deploy/frontend-deploy.yaml -f front-end/tekton-tasks/deploy/frontend-svc.yaml -f front-end/Pipeline.yaml -f front-end/PipelineRun.yaml -n test

install-monitoring: install-prometheus install-grafana
delete-monitoring: delete-prometheus delete-grafana

install-prometheus:
	echo "Monitoring: install-grafana" | tee -a output.log
	helm install -n monitoring -f platform/monitoring/prometheus-values.yaml prometheus prometheus-community/prometheus| tee -a output.log

delete-prometheus:
	echo "Monitoring: delete-prometheus" | tee -a output.log
	helm delete -n monitoring prometheus 2>/dev/null | true

install-grafana:
	echo "Monitoring: install-grafana" | tee -a output.log
	helm install grafana grafana/grafana -n monitoring -f platform/monitoring/grafana-values.yaml | tee -a output.log

delete-grafana:
	echo "Monitoring: delete-grafana" | tee -a output.log
	helm delete -n monitoring grafana 2>/dev/null | true

install-logging:
	./logging-monitoring/elf.sh
