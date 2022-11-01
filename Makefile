create: init cluster

init:
		@mkdir -p /tmp/volumes/k3d0
		@mkdir -p /tmp/volumes/k3d1
		@mkdir -p /tmp/volumes/k3d2
		@mkdir -p /tmp/volumes/k3d

cluster:
		k3d cluster create my-cluster --config k3d-config.yaml

down:
		k3d cluster delete my-cluster