// recette.php

<?php
function liste_recette($db){
	// Ecrire et effectuer la requête dans la bd
	$req = "SELECT `nom`, `id` FROM `recette`;";
	$query = $db->query($req);
	$row = $query->fetch_array();

	// Afficher le résultat dans un tableau avec des checkbox 
	echo "<form action=\"liste_course.php\" method=\"GET\">";
	while ($row) {
		echo "<input type=\"checkbox\" name=\"recette_select[]\" value=\" ".$row["id"]."\">
			<label for=\"recette_select\">".$row["nom"]."</label> <br>";
		$row = $query->fetch_array();
	}
	echo "<button type=\"submit\">Afficher ma liste de courses></button>";
	echo "</form>";

	// Libérer la mémoire et la db
	$query->free();
	$db->close();
}
?>
