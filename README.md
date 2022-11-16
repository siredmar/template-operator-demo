# template-operator-demo

Run the makefile to setup in your cluster. Tested on kind v1.22.

```console
$ make all
kubectl apply -f https://github.com/flanksource/template-operator/releases/download/v0.7.0/operator.yml
namespace/template-operator created
customresourcedefinition.apiextensions.k8s.io/rests.templating.flanksource.com created
customresourcedefinition.apiextensions.k8s.io/templates.templating.flanksource.com created
serviceaccount/template-operator-manager created
role.rbac.authorization.k8s.io/template-operator-leader-election-role created
clusterrole.rbac.authorization.k8s.io/template-operator-manager-role created
rolebinding.rbac.authorization.k8s.io/template-operator-leader-election-rolebinding created
clusterrolebinding.rbac.authorization.k8s.io/template-operator-manager-rolebinding created
service/template-operator-template-operator created
deployment.apps/template-operator-controller-manager created
mkdir -p /tmp/kubebuilder/bin
curl -L https://github.com/kubernetes-sigs/kubebuilder/releases/download/v3.7.0/kubebuilder_linux_amd64 -o /tmp/kubebuilder/bin/kubebuilder
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 31.4M  100 31.4M    0     0  6343k      0  0:00:05  0:00:05 --:--:-- 6745k
chmod +x /tmp/kubebuilder/bin/kubebuilder
cd crd && PATH=/home/armin/.nvm/versions/node/v16.17.0/bin:/home/armin/.local/bin:/home/armin/.cargo/bin:/home/armin/.local/bin:/home/armin/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/armin/.local/bin:~/bin:/home/armin/go/bin:/home/armin/.cargo/bin:/usr/local/go/bin:/home/armin/.pulumi/bin:/home/armin/.krew/bin:/home/armin/.arkade/bin:/home/armin/.fzf/bin:/home/armin/.garden/bin:/home/armin/.arkade/bin/:/tmp/kubebuilder/bin	make manifests
make[1]: Entering directory '/home/armin/edgefarm/template_test/crd'
/home/armin/edgefarm/template_test/crd/bin/controller-gen rbac:roleName=manager-role crd webhook paths="./..." output:crd:artifacts:config=config/crd/bases
make[1]: Leaving directory '/home/armin/edgefarm/template_test/crd'
rm -r /tmp/kubebuilder
kubectl apply -f crd/config/crd/bases
customresourcedefinition.apiextensions.k8s.io/edgeapplicationoverriders.edgeapplication.kubeedge created
kubectl create ns template --dry-run=client --output yaml | kubectl apply -f -
namespace/template created
kubectl apply -f resource_template/patch1.yaml
edgeapplicationoverrider.edgeapplication.kubeedge/unicorn created
kubectl apply -f resource_template/patch2.yaml
edgeapplicationoverrider.edgeapplication.kubeedge/rainbow created
kubectl apply -f resource_template/deploymentTemplate.yaml
template.templating.flanksource.com/bash created
```

Wait a few moments for everything to be up and running then check for the two deployments created

```console
$ kubectl get deployments.apps -n template
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
rainbow   1/1     1            1           16s
unicorn   1/1     1            1           16s
```
