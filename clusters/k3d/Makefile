create: init cluster
down: down
destroy: down delete cleanup

init:
		mkdir -p /tmp/volumes/k3d0
		mkdir -p /tmp/volumes/k3d1
		mkdir -p /tmp/volumes/k3d2
		mkdir -p /tmp/volumes/k3d

cluster:
		k3d cluster create my-cluster --config k3d-config.yaml

up:
		k3d cluster start my-cluster

down:
		k3d cluster stop my-cluster

delete:
		k3d cluster delete my-cluster

cleanup:
		rm -rf /tmp/volumes/k3d0
		rm -rf /tmp/volumes/k3d1
		rm -rf /tmp/volumes/k3d2
		rm -rf /tmp/volumes/k3d
