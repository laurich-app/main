import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.BeforeAll;

class Test {

    @BeforeAll
    public static void setUp() {
        String baseUrl = System.getenv("BASE_URL");
        if(baseUrl == null){
            baseUrl = "http://localhost:8080/api";
        }
        System.setProperty("karate.env", baseUrl);
    }

    /**
     * Vérifie le déroulement d'un scénario de base.
     * Scénario gestion produit : Connexion en tant qu'admin, ajouter une catégorie, ajouter un produit, vérifier qu'un bon de commande a bien été généré, mettre à jour le bon de commande comme livré afin d'incrémenter le stock du produit.
     * Scénario valider commande : Ensuite, s'inscrire, créer un panier, ajouter des items, valider la commande, vérifier que la commande a décrémenter le stock :
     * - puis vérifier que le stock étant inférieur à 5 une nouvelle demande de bon de commande a été généré.
     * - puis vérifier que la commande a été créer pour l'utilisateur.
     * @return
     */
    @Karate.Test
    Karate testProcess() {
        return Karate.run("gestion-produit", "proceed-commande").relativeTo(getClass());
    }
}

