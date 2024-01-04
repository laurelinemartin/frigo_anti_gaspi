// liste_course.php

<?php
function calcul_liste_courses(){
	// Connexion à la BD
	include("connexion.php");
	$db = connexion();

	// Requête SQL
	foreach($_GET['recette_select'] as $value){
	$req = "SELECT ing_valeur
	    	FROM recette r, ingredient i
	    	WHERE r.id = i.id_recette
	    	AND i.id_recette = '$value';";
	$query = $db->query($req);
	$row = $query->fetch_array();   
    }

    // Affichage du résultat
	while ($row) {
		echo "<p>".$row["ing_valeur"]."</pr>";
		$row = $query->fetch_array();
	}

	// Libération de la mémoire
	$query->free();
	$db->close();
}
/* function maj_liste_courses(){

}
function afficher_liste_courses(){

}*/

if(isset($_GET['recette_select']) && !empty($_GET['recette_select'])) {
	echo "Recette choisie : ";
    foreach($_GET['recette_select'] as $value){
        echo $value.'<br/>';
    }
}
else{
	echo "Oups";
}
calcul_liste_courses();
?>
