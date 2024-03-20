#!/bin/bash
# Limité seulement à télécharger les images Docker
docker login ghcr.io -u justin.lecas@gmail.com -p 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

# Vérifier si l'OS est un macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    docker compose up -d
else
    docker-compose up -d
fi