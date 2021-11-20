FROM openjdk:11 as base 
WORKDIR /app
COPY . .

RUN chmod +x gradlew
RUN ./gradlew clean
RUN ./gradlew build 

FROM tomcat:9
WORKDIR webapps
COPY --from=base /app/build/libs/demo-0.0.1-SNAPSHOT.jar .
RUN rm -rf ROOT && mv demo-0.0.1-SNAPSHOT.jar Demo.jar
ENTRYPOINT java -jar Demo.jar
