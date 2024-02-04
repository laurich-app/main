# Projet : site de vente de vêtements

---
## Service authentification

---

### Contexte
Micro service s'occupant de tout ce qui est authentification (inscription, connexion, déconnexion ...)

### Table des URI :

| Methods |            URI Gateway            |              URI              | Roles | Description                                                                 | Request                                                          | Response                               | Status Code |
|:-------:|:---------------------------------:|:-----------------------------:|:-----:|-----------------------------------------------------------------------------|:-----------------------------------------------------------------|:---------------------------------------|:-----------:|
|  POST   |        /api/auth/connexion        |        /auth/connexion        | USER  | Permet de se connecter, et renvoie une paire d'accès et de rafraichissement | Body : { email, password } <br/> Header : User-Agent             | Body : { access_token, refresh_token } |     200     |
|  POST   |       /api/auth/inscription       |       /auth/inscription       |   -   | Permet d'inscrire un compte                                                 |                                                                  |                                        |     201     |
|  POST   | /api/auth/token_raffraichissement | /auth/token_raffraichissement | USER  | Permet de régénérer une paire valide de token d'accès                       | Body : { access_token, refresh_token } <br/> Header : User-Agent | Body : { access_token, refresh_token } |     201     |
| DELETE  |       /api/auth/deconnexion       |       /auth/deconnexion       | USER  | Permet de se déconnecter d'un front                                         | Authorization : Bearer ${access_token}                           |                                        |     204     |
|   GET   |             /api/moi              |           /users/me           | USER  | Renvoie le profil de l'utilisateur connecté                                 | Authorization : Bearer ${access_token}                           |                                        |     200     |
|   GET   |                                   |         /users/${id}          |   -   | Renvoie le profil d'un utilisateur                                          |                                                                  |                                        |     200     |
|   GET   |            /api/users             |      /users?page=&limit=      | ADMIN | Récupérer les utilisateurs paginés                                          |                                                                  |                                        |     200     |