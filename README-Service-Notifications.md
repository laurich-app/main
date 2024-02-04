# Projet : site de vente de vêtements

---
## Service notifications

---

### Contexte
Micro service s'occupant de l'envoi de notifications aux utilisateurs par email.

---
### Notifications

- **Notification client et gestionnaire :**
  - Notifier quand le client a passé une commande (information de la commande ; avec tous le détail de la commande prix HT etc...)
  - _(**Actuellement pas l'info**)_ Notifier si livraison réussi 
  - _(**Optionnel**)_ Notifier en cas de perte d’un article
  - _(**Optionnel**)_ Notifier en cas de retard d’expédition


- **Notification client :**
  - _(**Pas d'utilisateur dans le panier**)_ Article mis ~~en favoris~~ ou dans le panier en rupture
  - _(**Pas de tâche cron possible (pas d'infra disponible)**)_ Validation de panier si panier non validé après 24h
  - _(**Pas d'utilisateur dans le panier**)_ Notification pour un article précis remis en stock si dans panier
  - _(**Optionnel**)_ Notifier si un article n’est plus vendu
  - _(**Pas géré**)_ Notifier en cas de promo ou réduction
  - _(**Optionnel**)_ Notification pour payement accepter ou refusé
  - _(**Pas géré**)_ Demande d’avis
  - Nouveaux articles (Voici un nouvel article disponible dans notre catalogue, n'hésitez pas à checker + un lien produit)
  - Notification inscription d’un nouveau client (Mail de confirmation, vous êtes bien inscrit)


- **Notification gestionnaire :**
  - Notifier en cas d'un seuil insuffisant de stock (seuil = 5)
  - _(**Pas géré**)_ Notification nouvelle arrivage
  - _(**Pas géré**)_ Notifier si fournisseur indisponible
  - _(**Pas géré**)_ Notifier les retours
  - _(**Pas géré**)_ Notifier les remboursements
  - _(**Pas géré**)_ Notifier les dysfonctionnements du site

---
### Table des URI :

| Methods |       URI Gateway        |         URI          | Roles | Description | Request | Response | Status Code |
|:-------:|:------------------------:|:--------------------:|:-----:|-------------|:--------|:---------|:-----------:|
|  POST   | /api/notifications/commande | /notifications/commande |       |             | Lors d'une commande, envoies un mail récapitulatif de la commande : avec toutes les informations de la commande.        |          |             |
|  POST   | /api/notifications/nouveaux_articles | /notifications/nouveaux_articles                     |       |             |         |          |             |
| POST | /api/notifications/inscription | /notifications/inscription |       |             |         |          |             |
| POST | /api/notifications/stock_insuffisant | /notifications/stock_insuffisant |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |
