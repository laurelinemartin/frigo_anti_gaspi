<!-- accueil.php -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Liste Anti-Gaspi</title>
</head>

<body>
	<h1>Choisir une recette</h1>
	<div class="menu">
		<form id="menu">
			<button name="afficher_le_frigo" id="fridge_item_list">Contenu du frigo</button>
			<button name="liste_de_courses" id="list">Liste de courses</button>
			<button name="detail_dune_recette" id=""
		</form>
	</div>
	<br>
	<div class="liste_des_recettes" align="content">
		<?php
			include("connexion.php");
			include("recette.php");
			$db = connexion();
			liste_recette($db);
		?>
	</div>
</body>
</html>
