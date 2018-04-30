echo "Provisioning virtual machine.."
sudo yum update -y
sudo yum upgrade -y 
sudo yum install -y epel-release 
sudo yum install -y wget
sudo yum install -y initscripts fontconfig

echo "add repository package"

cat <<EOF | sudo tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF

echo "install package"

sudo yum update -y

sudo yum -y install influxdb 
sudo systemctl start influxdb

sudo yum -y install telegraf
sudo systemctl start telegraf

wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.1.0-1.x86_64.rpm
sudo yum install grafana-5.1.0-1.x86_64.rpm
sudo systemctl daemon-reload
sudo systemctl start grafana-server




