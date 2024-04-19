#!/bin/bash

# Nom de l'image Docker
DOCKER_IMAGE="karate_laurichapp"

# Construire l'image Docker à partir du Dockerfile
docker build -t $DOCKER_IMAGE ./karate/

# Lancer le conteneur Docker en spécifiant le paramètre d'environnement
docker run --rm --network laurichapp_networks -v $PWD/karate-test-result/:/app/target/karate-reports/ -e "BASE_URL=http://service-passerelle:8080/api" $DOCKER_IMAGE > result_test.txt
