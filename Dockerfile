# Етап збірки
FROM gradle:8.5-jdk17 AS build
WORKDIR /home/gradle/src
COPY --chown=gradle:gradle . .

# Збираємо тільки JAR, пропускаючи тести (це зекономить тобі 2-3 хвилини)
RUN chmod +x gradlew
RUN ./gradlew shadowJar --no-daemon -x test || ./gradlew buildFatJar --no-daemon -x test || ./gradlew build --no-daemon -x test

# Етап запуску
# Використовуємо JRE (вона легша) і версію 17, щоб збігалася з білдом
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Копіюємо тільки потрібний JAR
# Ktor зазвичай створює -all.jar або fat.jar.
COPY --from=build /home/gradle/src/build/libs/*all.jar server.jar || \
COPY --from=build /home/gradle/src/build/libs/*fat.jar server.jar || \
COPY --from=build /home/gradle/src/build/libs/*.jar server.jar

EXPOSE 8081
# Оптимізація пам'яті для малинки
CMD ["java", "-Xmx256M", "-jar", "server.jar"]