ARCH=arm
REGISTRY_PREFIX=gcr.io/google_containers
images=( \
	pause-${ARCH}:3.0 \
	etcd-${ARCH}:3.0.17 \
	kube-apiserver-${ARCH}:v1.8.2 \
	kube-controller-manager-${ARCH}:v1.8.2 \
	kube-scheduler-${ARCH}:v1.8.2 \
	kube-proxy-${ARCH}:v1.8.2 \
	kubernetes-dashboard-init-${ARCH}:v1.0.1 \
	kubernetes-dashboard-${ARCH}:v1.7.1 \
	heapster-influxdb-${ARCH}:v1.3.3 \
	heapster-grafana-${ARCH}:v4.4.3 \
	heapster-${ARCH}:v1.4.0 \
	k8s-dns-sidecar-${ARCH}:1.14.5 \
	k8s-dns-kube-dns-${ARCH}:1.14.5 \
	k8s-dns-dnsmasq-nanny-${ARCH}:1.14.5 \
	kube-addon-manager:v6.4-beta.2 \
)

function pull_images() {
    for img in ${images[@]}; do
        echo "===>" $img
        docker pull $REGISTRY_PREFIX/$img
    done
}

function save_images() {
    for img in ${images[@]}; do
        echo "===>" $img
        docker save -o $1/$img $REGISTRY_PREFIX/$img
    done
}

case "$1" in
    pull)
        pull_images
        ;;
    save)
        save_images $2
        ;;
    *):
        print_usage
        ;;
esac
