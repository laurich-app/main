# Utiliser l'image Maven officielle
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers de votre projet (y compris le pom.xml) dans le conteneur
COPY . /app/

# Exécuter Maven pour construire le projet et exécuter les tests Karate
RUN mvn clean package -DskipTests=true

CMD mvn test