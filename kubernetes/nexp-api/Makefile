
deploy:
	@echo '************                               ************'
	@echo '************       Deploy                  ************'
	@echo '************                               ************'
	helm install nexp-api ./ -f values-minikube.yaml -f values.override.yaml

deploy_gcp:
	@echo '************                               ************'
	@echo '************       Deploy                  ************'
	@echo '************                               ************'
	helm install nexp-api ./ -f values-gcp.yaml -f values.override.yaml

upgrade:
	@echo '************                               ************'
	@echo '************       Deploy                  ************'
	@echo '************                               ************'
	helm upgrade nexp-api ./ -f values-minikube.yaml -f values.override.yaml

upgrade_gcp:
	@echo '************                               ************'
	@echo '************       Deploy                  ************'
	@echo '************                               ************'
	helm upgrade nexp-api ./ -f values-gcp.yaml -f values.override.yaml

uninstall:
	@echo '************                               ************'
	@echo '************       Deploy                  ************'
	@echo '************                               ************'
	helm uninstall nexp-api

uninstall_gcp:
	@echo '************                               ************'
	@echo '************       Deploy                  ************'
	@echo '************                               ************'
	helm uninstall nexp-api

minikube_service:
	@echo '************                               ************'
	@echo '************       Service                 ************'
	@echo '************                               ************'
	minikube service nexp-api --url -n nexp-api

template:
	@echo '************                               ************'
	@echo '************       Get Templates           ************'
	@echo '************                               ************'
	bash split.sh
