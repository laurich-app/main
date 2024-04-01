Feature: Faire une commande

  Background:
    * url BASE_URL

  Scenario: Faire une commande
    # S'inscrire
    # Création d'un email unique
    * def timestamp = java.lang.System.currentTimeMillis()
    * def email = timestamp + "@gmail.com"

    Given path '/users'
    And request { pseudo: 'Test', email: '#(email)', motDePasse: 'Test' }
    When method post
    Then status 201

    * def userToken = karate.response.header('Authorization').slice(7)

    # Lister les items disponible (vérifier le stock : 0 < stock < 5)
    Given path '/produits'
    And param limit = 50
    And param page = 0
    And header Authorization = 'Bearer ' + userToken
    When method get
    Then status 200

    * assert karate.response.body.data.length > 0
    * def idProduit = ""
    * def quantiteChoisi = 0
    * def couleurChoisi = ""
    * def find =
    """
    function(produit) {
      if(produit.stock.length > 0){
        karate.forEach(produit.stock, function(stock){
          if(stock.quantite > 0){
            quantiteChoisi = stock.quantite
            idProduit = produit.id
            couleurChoisi = stock.couleur
          }
        })
      }
    }
    """
    * karate.forEach(karate.response.body.data, find)
    * assert quantiteChoisi != 0

    # Créer un panier
    Given path '/paniers'
    And request { id: '#(idProduit)', couleur_choisi: '#(couleurChoisi)', quantite: '#(quantiteChoisi)' }
    When method post
    Then status 201

    * def tokenPanier = karate.response.body.token

    # Valider la commande
    Given path '/paniers/' + tokenPanier + '/valider_commande'
    And header Authorization = 'Bearer ' + userToken
    When method post
    Then status 201

#    * karate.pause(500)
    * def delay = 500
    * eval java.lang.Thread.sleep(delay)

    # Utilisateur : vérifier que la commande a été créer
    Given path '/commandes'
    And param limit = 50
    And param page = 0
    And header Authorization = 'Bearer ' + userToken
    When method get
    Then status 200

    # On créé un nouvel utilisateur à chaque fois, donc on sait que c'est bien cette commande qui est créé
    * assert karate.response.body.pagination.nbItem == 1

    # Boncommande : vérifier qu'un nouveau bon de commande a été créer pour le produit
    # Connexion en admin
    Given path '/auth/connexion'
    And request { email: 'root@root.com', motDePasse: 'root' }
    When method post
    Then status 200

    * def adminToken = karate.response.header('Authorization').slice(7)

    # Vérification
    # Vérifier que deux bons de commandes ont bien été créer
    Given path '/boncommandes'
    And param limit = 1000
    And param page = 1
    And header Authorization = 'Bearer ' + adminToken
    When method get
    Then status 200

    # Vérifier que chaque produit a l'ID spécifié et toutes les couleurs spécifiées
    * def allProductsValid = false
    * def findBoncommande =
    """
    function(boncommande) {
      const produit = boncommande.produit
      if(produit.id_produit_catalogue == idProduit && produit.couleur == couleurChoisi && boncommande.etat_commande == "EN_COURS"){
        allProductsValid = true
      }
    }
    """
    * karate.forEach(karate.response.body.data, findBoncommande)
    * assert allProductsValid