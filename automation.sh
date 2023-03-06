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

fi

docroot="/var/www/html"
# Check if inventory file exists
if [[ ! -f ${docroot}/inventory.html ]]; then
	#statements
	echo -e 'Log Type\t-\tTime Created\t-\tType\t-\tSize' > ${docroot}/inventory.html
fi

# Inserting Logs into the file
if [[ -f ${docroot}/inventory.html ]]; then
	#statements
    size=$(du -h /tmp/${name}-httpd-logs-${timestamp}.tar | awk '{print $1}')
	echo -e "httpd-logs\t-\t${timestamp}\t-\ttar\t-\t${size}" >> ${docroot}/inventory.html
fi

# Create a cron job that runs service every minutes/day
if [[ ! -f /etc/cron.d/automation ]]; then
	#statements
	echo "* * * * * root /root/automation.sh" >> /etc/cron.d/automation
fi
