# Projet Laurich'App

### Fait par le groupe 1 :
-	Justin LECAS : N° 2197502
-	Loic MALON : N° 2198645
-	Lauriche  TSONGOUANG SONGFACK : N° 2145372
-	Soumia DELMI : N° 2182576
-	Nadir SAIAH : N° 2164158

### Année : Master 2 MIAGE - 2024
------------

Mise en place de l'environnement de travail :
----------------

**1-** On lance tout d'abord l'application **Docker Desktop** :

Lien de téléchargement : [ici](https://www.docker.com/products/docker-desktop/)

**2-** On démarre nos conteneurs docker
Il suffit d'executer le script bash init.sh
```
./init.sh
```

Celui-ci vous connecteras avec une clé permettant seulement de download les images du registre du projet, et démarreras ensuite les docker compose.

Le projet est disponible à l'URL http://localhost:8080.

Le projet est entièrement démarrer lorsque tous les services sont référencer sur consul.

Il y'a 9 services.

Les services sont :

- consul
- reapprovisionnement
- passerelle
- notification
- utilisateur
- commande
- catalogue
- service-configuration
- rabbitmq

Un Karate est disponible contenant les deux scénarios les plus important de notre application : réapprovisionner le stock et valider une commande. Chacun d'entre eux est décris dans la classe de test associé.

Lorsque l'on créer un produit, on n'enregistre pas de stock par défaut mais on génère une demande de réapprovisionnement automatiquement. Une fois le bon de commande livré, le gestionnaire indique que le bon de commande a été livré ce qui incrémente le stock correspondant. Nous possédons un stock de produit par couleur (chaque couleur à un stock spécifique).

Un utilisateur peut ensuite ajouter dans son panier des produits possédant un stock non vide. Il peut ensuite valider son panier, ce qui décrémente le stock correspondant, et ajoute une nouvelle demande de réapprovisionnement.

Il y'a également un service de notification, qui envoie un mail à l'utilisateur ayant passé commande, et lors de son inscription. Afin de tester cette partie, nous vous proposons d'utiliser le client.

Il y'a un compte gestionnaire afin de rajouter des produits, des catégories, etc... :

- email : root@root.com
- password : root

Vous pouvez, soit run le test via Java, soit utilisé le script shell `run_karate.sh` qui exécutera une image Docker avec le script Karate et enregistrera le résultat dans un fichier `result_test.txt`.

Tel que :

```sh
./run_karate.sh
```

Le dossier karate-test-result contient un fichier karate-summary.html que vous pouvez consulter en ligne.
