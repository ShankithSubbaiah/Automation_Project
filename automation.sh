sudo apt update -y
echo "packages updated successfully"
apache2 --version
apt-get install apache2
echo "apache2 installed successfully"
systemctl list-units --type=service --state=running
echo "apache2 server is enabled and running"
name=$'pradyumn'
timestamp=$(date '+%d%m%Y-%H%M%S')
tar cvf- $name-httpd-logs-$timestamp.tar /var/log/apache2/access.log /var/log/apache2/error.log
echo "tar file created"
mv $name-httpd-logs-$timestamp.tar /tmp/$name-httpd-logs-$timestamp.tar
echo "tar moved to /tmp/ directory"
sudo apt update
sudo apt install awscli
echo "awscli installed"
aws s3 \
cp /tmp/$name-httpd-logs-$timestamp.tar \
s3://upgrad-pradyumn/$name-httpd-logs-$timestamp.tar
