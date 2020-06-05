#!/bin/sh

validurl="https://rohdin@bitbucket.org/rohdin/rohini.git"

#Assiging a value:
URL="https://rohdin@bitbucket.org/rohdin"

#getting repository name:
echo "Enter the repository:"
read repo

#Building the Repository link:
ComURL="$URL/$repo.git"

if [ "$validurl" ==  "$ComURL" ]
then
#cloning repository:
	git clone $ComURL
else
	echo "invalid url"
	break
fi


if [ $? == 0 ]
then

		echo "it worked"
else
	echo "failed"
fi

#change to rohini DIR:
cd $repo

#Build package:
#mvn package

#deploy the package into tomcat
#cp /home/ec2-user/scripts/rohini/target/myweb*war /opt/tomcat7/webapps/

#restart tomcat
#cd /opt/tomcat7/bin/
#./shutdown.sh

#./startup.sh

