FROM tomcat:9.0

COPY target/UserAccessManagement-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/UserAccessManagement.war

EXPOSE 8080
