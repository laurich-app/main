Feature: Gestion produit

  Background:
    * url BASE_URL

  Scenario: Gestion des produits
    # Connexion admin
    Given path '/auth/connexion'
    And request { email: 'root@root.com', motDePasse: 'root' }
    When method post
    Then status 200

    * def adminToken = karate.response.header('Authorization').slice(7)

    # Ajout d'une catégorie
    Given path '/categories'
    And header Authorization = 'Bearer ' + adminToken
    And request { libelle: "T-shirt" }
    When method post
    Then status 201

    * def idCategorie = karate.response.body.id
    * def couleurs = ["VERT", "ROUGE"]

    # Ajouter un produit avec deux stocks
    Given path '/produits'
    And header Authorization = 'Bearer ' + adminToken
    And request { "prix_unitaire": 12, "sexe": "HOMME", "taille": "S", "image_url": "https://image_url", "description": "Ma description", "libelle": "Mon libelle", "couleurs": "#(couleurs)", "categorie_id": "#(idCategorie)" }
    When method post
    Then status 201

    * def idProduit = karate.response.body.id

    # Vérifier que deux bons de commandes ont bien été créer
    Given path '/boncommandes'
    And param limit = 1000
    And param page = 1
    And header Authorization = 'Bearer ' + adminToken
    When method get
    Then status 200

    # Vérifier que chaque produit a l'ID spécifié et toutes les couleurs spécifiées
    * def allProductsValid = false
    * karate.set('couleurs', couleurs)
    * karate.set('id_produit', idProduit)
    * def idBoncommande = ""
    * def couleurChoisi = ""
    * def fun =
    """
    function(boncommande) {
      const produit = boncommande.produit
      karate.forEach(couleurs, function(couleur){
        if(produit.id_produit_catalogue == idProduit && produit.couleur == couleur){
          allProductsValid = true
          couleurChoisi = produit.couleur
          idBoncommande = boncommande.id
        }
      })
    }
    """
    * karate.forEach(karate.response.body.data, fun)
    * assert allProductsValid

    # Met à jour un bon de commande
    Given path '/boncommandes/' + idBoncommande + '/etat'
    And header Content-Type = 'application/json'
    And header Authorization = 'Bearer ' + adminToken
    And request { "etat": "LIVRER" }
    When method put
    Then status 200

    # Attendre que rabbitmq soit bien popularisé
#    * karate.pause(1500)
    * def delay = 500
    * eval java.lang.Thread.sleep(delay)

    # Vérifier que le stock a été incrémenter
    Given path '/produits/' + idProduit
    And header Authorization = 'Bearer ' + adminToken
    When method get
    Then status 200

    * def result = false
    * def find =
    """
    function(stock) {
      if(couleurChoisi == stock.couleur && stock.quantite == 5) {
        result = true
      }
    }
    """
    * karate.forEach(karate.response.body.stock, find)
    * assert result