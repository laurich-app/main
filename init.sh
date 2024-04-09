#!/bin/bash
# Limité seulement à télécharger les images Docker
docker login ghcr.io -u justin.lecas@gmail.com -p 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

# Vérifier si l'OS est un macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    docker compose up -d
else
    docker-compose up -d
fi

# écoute du redémarrage du service-utilisateur afin de redémarrer automatiquement les services associés. (JWT issue ;) )
SERVICE_NAME="service-utilisateur"
PREVIOUS_RESTART_COUNT=$(docker inspect --format='{{.RestartCount}}' "$SERVICE_NAME")
SOMMEIL="15"

# Tableau contenant les noms de plusieurs services à surveiller
SERVICES=("service-commande" "service-reappro" "service-produits" "service-notification")

# Fonction pour redémarrer tous les services un à un
restart_services() {
    for service in "${SERVICES[@]}"; do
        docker restart "$service"
        echo "Service $service redémarré."
    done
}

# Fonction pour vérifier si un service est en état "healthy"
is_healthy() {
    local service_name="$1"
    local health_status=$(docker inspect --format='{{.State.Health.Status}}' "$service_name")
    if [ "$health_status" = "healthy" ]; then
        return 0 # Le service est "healthy"
    else
        return 1 # Le service n'est pas "healthy"
    fi
}

echo "On écoute le redémarrage du service utilisateur afin de redémarrer les services dépendants le cas échéant"
while true; do
    RESTART_COUNT=$(docker inspect --format='{{.RestartCount}}' "$SERVICE_NAME")
    
    if [ "$RESTART_COUNT" -gt "$PREVIOUS_RESTART_COUNT" ]; then
        echo "Le service $SERVICE_NAME a redémarré."
        # Attendre que le service principal devienne "healthy"
        while ! is_healthy "$SERVICE_NAME"; do
            sleep "$SOMMEIL"
        done
        echo "Le service $SERVICE_NAME est maintenant healthy."
        restart_services # Redémarrer tous les services du tableau
    fi
    
    PREVIOUS_RESTART_COUNT="$RESTART_COUNT"
    
    # Optionnel : ajustez l'intervalle de surveillance en fonction de vos besoins.
    sleep "$SOMMEIL"
done