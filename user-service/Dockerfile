FROM eclipse-temurin:17-jdk-alpine
WORKDIR /user-service
COPY . /user-service
ARG DEPLOY_ENV
RUN ./gradlew build -x check --info
EXPOSE 8080
CMD ["sh", "-c", ". script/env-$DEPLOY_ENV && java $JAVA_OPTS -jar user-service/build/libs/user-service.jar"]
