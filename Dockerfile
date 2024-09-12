FROM maven:3.8.3-openjdk-17

WORKDIR /app

COPY . .
RUN mvn package
RUN mv target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "app.jar" ]
