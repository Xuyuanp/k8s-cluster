PROXY_IP=$1
PROXY_PORT=$2
PROXY="http://${PROXY_IP}:${PROXY_PORT}"

echo "config docker proxy"
mkdir -p /etc/systemd/system/docker.service.d/
cat <<EOF > /etc/systemd/system/docker.service.d/proxy.conf
[Service]
Environment="HTTP_PROXY=http://${PROXY}/" "HTTPS_PROXY=${PROXY}/" "NO_PROXY=localhost,127.0.0.1,registry.docker-cn.com"
EOF
echo "restart docker"
systemctl daemon-reload && systemctl restart docker

echo "config apt proxy"
cat <<EOF > /etc/apt/apt.conf.d/proxy
Acquire::http::Proxy "http://${PROXY}";
Acquire::https::Proxy "http://${PROXY}";
EOF
