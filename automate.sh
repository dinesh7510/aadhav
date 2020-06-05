#!/bin/sh

url="https://rohdin@bitbucket.org/rohdin"

rm -rf $1 #removing the existing git folder

#Build url
re="$url/$1.git"

echo $re

#git function
gitcloning(){
	validurl="https://rohdin@bitbucket.org/rohdin/rohini.git"
	if [ $1 == $validurl ]
	then
		git clone $1
	else
		echo $1
	fi
}


#Maven build

mavenbuild(){
	
	cd ~/scripts/$1
	mvn package
	cd ./target

	cp ./myweb-2.0.war /opt/tomcat7/webapps/myweb.war
}

#tomcat deployment
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


#invoking function

gitcloning $re

mavenbuild $1

cd /opt/tomcat7/webapps
rm -rf myweb*

tomcat shutdown start
