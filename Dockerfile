FROM ubuntu:latest
LABEL authors="ydazhuk"

#ENTRYPOINT ["top", "-b"]

# Використовуємо образ з JDK
FROM openjdk:17-jdk-slim

# Копіюємо збірку нашого сервера (спочатку зроби ./gradlew build)
COPY build/libs/*-all.jar /app/server.jar

# Відкриваємо порт
EXPOSE 8080

# Запускаємо додаток
CMD ["java", "-jar", "/app/server.jar"]