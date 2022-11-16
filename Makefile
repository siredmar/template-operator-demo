.PHONY: all
all: install build apply

.PHONY: install_template_operator
install: install_template_operator

.PHONY: build
build: build_crd

.PHONE: apply
apply: apply_crd apply_resources

.PHONY: install_template_operator
install_template_operator:
	kubectl apply -f https://github.com/flanksource/template-operator/releases/download/v0.7.0/operator.yml

.PHONY: build_crd
build_crd:
	mkdir -p /tmp/kubebuilder/bin
	curl -L https://github.com/kubernetes-sigs/kubebuilder/releases/download/v3.7.0/kubebuilder_linux_amd64 -o /tmp/kubebuilder/bin/kubebuilder
	chmod +x /tmp/kubebuilder/bin/kubebuilder
	cd crd && PATH=${PATH}:/tmp/kubebuilder/bin	make manifests
	rm -r /tmp/kubebuilder

.PHONY: apply_crd
apply_crd:
	kubectl apply -f crd/config/crd/bases

.PHONY: apply_resources
apply_resources:
	kubectl create ns template --dry-run=client --output yaml | kubectl apply -f -
	kubectl apply -f resource_template/patch1.yaml
	kubectl apply -f resource_template/patch2.yaml
	kubectl apply -f resource_template/deploymentTemplate.yaml

.PHONY: clean
clean:
	kubectl delete template -A --all
	kubectl delete edgeapplicationoverriders -A --all
	kubectl delete crd edgeapplicationoverriders.edgeapplication.kubeedge
	kubectl delete ns template