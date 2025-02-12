# Use a base image with Java runtime environment
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the compiled Spring Boot JAR file to the container
# Replace the path with the location of your JAR file
COPY target/spring-boot-app.jar /app/app.jar

# Expose the port the app will run on (default is 8080 for Spring Boot apps)
EXPOSE 8080

# Set the command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
