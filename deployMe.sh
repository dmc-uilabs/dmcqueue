## ---------------------------------------------------------------------------
## Licensed to the Apache Software Foundation (ASF) under one or more
## contributor license agreements.  See the NOTICE file distributed with
## this work for additional information regarding copyright ownership.
## The ASF licenses this file to You under the Apache License, Version 2.0
## (the "License"); you may not use this file except in compliance with
## the License.  You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
## ---------------------------------------------------------------------------

# Defines users that can access the web (console, demo, etc.)
# username: password [,rolename ...]
admin: admin, admin
user: user, user
#!/bin/bash -v
echo Stop sendmail... > /home/ec2-user/activemqSetup.log 2>&1
/etc/init.d/sendmail stop > /home/ec2-user/activemqSetup.log 2>&1

echo Updating system... > /home/ec2-user/activemqSetup.log 2>&1
yum -y update >> /home/ec2-user/activemqSetup.log 2>&1

echo "Creating folder for ActiveMQ..." >> /home/ec2-user/activemqSetup.log 2>&1
mkdir /opt/activemq >> /home/ec2-user/activemqSetup.log 2>&1
cd /opt/activemq/ >> /home/ec2-user/activemqSetup.log 2>&1

echo "Downloading and unpacking dependencies..." >> /home/ec2-user/activemqSetup.log 2>&1
yum install -y wget >> /home/ec2-user/activemqSetup.log 2>&1
wget http://archive.apache.org/dist/activemq/apache-activemq/5.9.0/apache-activemq-5.9.0-bin.tar.gz >> /home/ec2-user/activemqSetup.log 2>&1
tar -zxvf apache-activemq-5.9.0-bin.tar.gz >> /home/ec2-user/activemqSetup.log 2>&1

echo "Creating ActiveMQ user..." >> /home/ec2-user/activemqSetup.log 2>&1
/usr/sbin/useradd activemq >> /home/ec2-user/activemqSetup.log 2>&1
touch /etc/default/activemq >> /home/ec2-user/activemqSetup.log 2>&1
chown activemq /etc/default/activemq >> /home/ec2-user/activemqSetup.log 2>&1
chmod 600 /etc/default/activemq >> /home/ec2-user/activemqSetup.log 2>&1

echo "Starting ActiveMQ..." >> /home/ec2-user/activemqSetup.log 2>&1
sudo su activemq >> /home/ec2-user/activemqSetup.log 2>&1

cp -v  /tmp/jetty-realm.properties /opt/activemq/apache-activemq-5.9.0/conf/jetty-realm.properties
chmod 644 /opt/activemq/apache-activemq-5.9.0/conf/jetty-realm.properties

/opt/activemq/apache-activemq-5.9.0/bin/activemq start >> /home/ec2-user/activemqSetup.log 2>&1
