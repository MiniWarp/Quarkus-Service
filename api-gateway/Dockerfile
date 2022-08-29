FROM eclipse-temurin:17-jdk-alpine
WORKDIR /api-gateway
COPY . /api-gateway
ARG DEPLOY_ENV
RUN ./gradlew build -x check --info
EXPOSE 8080
CMD ["sh", "-c", ". script/env-$DEPLOY_ENV && java $JAVA_OPTS -jar api-gateway/build/libs/api-gateway.jar"]
