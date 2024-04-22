FROM tomcat:latest
COPY target/helloworld.war /usr/local/webapps/hello.war
EXPOSE 8080
CMD ["cataline.sh", "run"]