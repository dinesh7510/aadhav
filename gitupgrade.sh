#!/bin/sh

#Variables:

rvalidurl="https://rohdin@bitbucket.org/rohdin/rohini.git"
dvalidurl="https://rohdin@bitbucket.org/rohdin/dinesh.git"
url="https://rohdin@bitbucket.org/rohdin"

echo "Enter repository name:"
read repo

rm -rf $repo

#Build url
re="$url/$repo.git"

#cloning function:

gitclone(){
        git clone $re
}

#Build function:

mvnbuild() {
	mvn package
}

#Shutdown and restart tomcat:

tomcat(){

	if [ $1 == "shutdown" ]
	then
		cd /opt/tomcat7/bin/
		./shutdown.sh
		echo "shutdown success"
	else
		echo "shutdown failed"
	fi
	
	if [ $2 == "start" ]
	then
		cd /opt/tomcat7/bin/
		./startup.sh
		echo "startup success"
	else
		echo "start failed"
	fi
}


#check valid URL or not to clone the repository:

if [ $rvalidurl == $re -o $dvalidurl == $re ]
then
	gitclone
else
	echo "incorrect repo"
fi

#Build the web page and deploy into tomcat

cd ~/scripts/$repo/simpleapp/

mvnbuild

#deployment
cd /opt/tomcat7/webapps
rm -rf simpleapp*
cp ~/scripts/$repo/simpleapp/target/simple-app-1.0.0.war /opt/tomcat7/webapps/simpleapp.war

tomcat shutdown start
