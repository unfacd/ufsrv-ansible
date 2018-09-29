
.PHONY: targets
targets:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

#this relies on the presence of a docker based ansible container, acting as a conttoller. Adjust for your local environment.
.PHONY: build_ufsrv
build_ufsrv:
	docker run -it -v /home/devops/.ssh/key_devops:/root/.ssh/key_devops -v /home/devops/ansible:/ansible/playbooks ansible_controller -i hosts_prod build_ufsrv_websock.yml
