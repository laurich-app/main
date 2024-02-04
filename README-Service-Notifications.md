# Projet : site de vente de vêtements

---
## Service notifications

---

### Contexte
Micro service s'occupant de l'envoi de notifications aux utilisateurs par email.

---
### Notifications

- **Notification client et gestionnaire :**
  - Notifier quand le client a passé une commande
  - Notifier si livraison réussi
  - _(**Optionnel**)_ Notifier en cas de perte d’un article
  - _(**Optionnel**)_ Notifier en cas de retard d’expédition


- **Notification client :**
  - Article mis en favoris ou dans le panier en rupture
  - Validation de panier si panier non validé après 24h
  - Notification pour un article précis remis en stock
  - Notifier si un article n’est plus vendu
  - Notifier en cas de promo ou réduction
  - Notification pour payement accepter ou refusé
  - Demande d’avis
  - Nouveaux articles
  - Notification inscription d’un nouveau client


- **Notification gestionnaire :**
  - Notifier en cas de rupture de stock
  - Notification nouvelle arrivage
  - Notifier si fournisseur indisponible
  - Notifier les retours
  - Notifier les remboursements
  - Notifier les dysfonctionnements du site

---
### Table des URI :

| Methods |       URI Gateway        |         URI          | Roles | Description | Request | Response | Status Code |
|:-------:|:------------------------:|:--------------------:|:-----:|-------------|:--------|:---------|:-----------:|
|  POST   | /api/notifications/email | /notifications/email |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |
|         |                          |                      |       |             |         |          |             |