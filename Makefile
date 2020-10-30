all: serviceAccount ship cart catalogues order users payments frontend test pipeline

pipeline:
	kubectl apply -f pipeline.yaml -f pipelineRun.yaml -n test
	tkn pipelinerun logs --last -f -n test
test:
	kubectl apply -f e2e-js-test/tekton-tasks/docker/task.yaml -f e2e-js-test/tekton-tasks/deploy/task.yaml -n test

serviceAccount:
	kubectl apply -f secrets.yaml -f serviceAccount.yaml -f clusterRole.yaml -f roleBinding.yaml -n test


ship:
	kubectl apply -f shipping/tekton-tasks/docker/task.yaml -f shipping/tekton-tasks/deploy/shipping-deploy.yaml -f shipping/tekton-tasks/deploy/shipping-svc.yaml -n test



cart:
	kubectl apply -f carts/tekton-tasks/docker/task.yaml -f carts/tekton-tasks/deploy/carts-deploy.yaml -f carts/tekton-tasks/deploy/carts-svc.yaml -f carts/tekton-tasks/deploy/cartsdb-deploy.yaml -f carts/tekton-tasks/deploy/cartsdb-svc.yaml -n test


catalogues:
	kubectl apply -f catalogue/tekton-tasks/docker/taskdb.yaml -f catalogue/tekton-tasks/docker/task.yaml -f catalogue/tekton-tasks/deploy/cataloguedb-deploy.yaml -f catalogue/tekton-tasks/deploy/cataloguedb-svc.yaml -f catalogue/tekton-tasks/deploy/catalogue-deploy.yaml -f catalogue/tekton-tasks/deploy/catalogue-svc.yaml -n test


order:
	kubectl apply -f orders/tekton-tasks/docker/task.yaml -f orders/tekton-tasks/deploy/orders-deploy.yaml -f orders/tekton-tasks/deploy/orders-svc.yaml -f orders/tekton-tasks/deploy/ordersdb-deploy.yaml -f orders/tekton-tasks/deploy/ordersdb-svc.yaml -n test


users:
	kubectl apply -f user/tekton-tasks/docker/taskdb.yaml -f user/tekton-tasks/docker/task.yaml -f user/tekton-tasks/deploy/userdb-deploy.yaml -f user/tekton-tasks/deploy/userdb-svc.yaml -f user/tekton-tasks/deploy/user-deploy.yaml -f user/tekton-tasks/deploy/user-svc.yaml -n test


payments:
	kubectl apply -f payment/tekton-tasks/docker/task.yaml -f payment/tekton-tasks/deploy/payment-deploy.yaml -f payment/tekton-tasks/deploy/payment-svc.yaml -n test


frontend:
	kubectl apply -f front-end/tekton-tasks/docker/task.yaml -f front-end/tekton-tasks/deploy/ingresstask.yaml -f front-end/tekton-tasks/deploy/frontend-deploy.yaml -f front-end/tekton-tasks/deploy/frontend-svc.yaml -n test
