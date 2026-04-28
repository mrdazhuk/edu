FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Копіюємо вже готовий JAR з контексту збірки
COPY build/libs/*-all.jar server.jar
EXPOSE 8081
CMD ["java", "-Xmx256M", "-jar", "server.jar"]