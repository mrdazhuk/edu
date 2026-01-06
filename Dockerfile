FROM ubuntu:latest
LABEL authors="ydazhuk"

# Етап збірки
FROM gradle:8.5-jdk17 AS build
WORKDIR /home/gradle/src
COPY --chown=gradle:gradle . .

# Даємо права на виконання та збираємо проект через стандартний build
RUN chmod +x gradlew
RUN ./gradlew build --no-daemon

# Етап запуску
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app

# Копіюємо файл. Ми використовуємо wildcard (*), щоб Docker знайшов JAR,
# навіть якщо він називається не так, як ми очікуємо.
COPY --from=build /home/gradle/src/build/libs/*.jar server.jar

EXPOSE 8080
CMD ["java", "-jar", "server.jar"]