# Етап збірки
FROM gradle:8.5-jdk17 AS build
WORKDIR /home/gradle/src
COPY --chown=gradle:gradle . .

# Збираємо Fat JAR (плагін Ktor)
RUN chmod +x gradlew
RUN ./gradlew buildFatJar --no-daemon -x test

# Етап запуску
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Ktor плагін гарантовано створює файл, що закінчується на -all.jar
COPY --from=build /home/gradle/src/build/libs/*-all.jar server.jar

EXPOSE 8081
CMD ["java", "-Xmx256M", "-jar", "server.jar"]