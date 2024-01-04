# Frigo anti-gaspi

Application web HTML/CSS/PHP permettant la gestion des stocks d'une cuisine. A l'aide d'une base de données et de requêtes SQL, l'application ajoute automatiquement les ingrédients qui manquent à la liste de courses selon la recette sélectionnée. Une fois les courses effectuées, ces ingrédients seront ajoutés aux stocks de la cuisine.

# Age : 12 / 17 ans
# Temps : 2 jours
# Prérequis : Bases en HTML seraient un plus pour aller plus vite sur cette partie.

### Notions :

- Langage utilisé : HTML / CSS / PHP
- Manipuler des base de données relationnelle (modéliser des tables, des entités et des attributs)
- Faire des requêtes SQL (création/create table, sélection/select, Insertion/insert, jointure/join, suppression/delete, mise à jour/update... )

### Fonctionnalités :

- Ajouter des aliments
- Afficher une liste de courses
- Remplir une liste de courses
- Indiquer que les courses ont été faites 
⇒ Supprimer la liste de courses
⇒ Ajouter les éléments dans la base

- Ajouter des recettes
- Sélectionner une recette
- Sauvegarder une liste de courses
- Indiquer qu'une recette a été réalisée
⇒ Supprimer les ingrédients utilisés par la recette

*Bonus : Ajouter une table "ustensiles", meilleur design de l'appli, toute bonne idée en fait...*

### Déroulement :

- Un peu d'HTML pour la page d'accueil
- Un peu de CSS
    
    Faire le CSS pour le design principal de l'application
    
- Gérer les pages
    
    Préparer une autre page pour l'ajout de recette
    
- Créer la bases de données et les tables
    
    Là tout plein de PHP et de SQL
    
    Table Recette, Table Aliment
    
- 

### Evaluation / Finalité
Possibilité d'afficher le contenu de la cuisine. Ajouter ou supprimer des ingrédients. Sélectionner une recette. Consulter la liste de courses.

### Retours :

---

### Ressources / Code

Modèle EA : http://www.info.univ-angers.fr/~gh/Pluripass/Db/ea.pdf

Ecrire la requête pour afficher les aliments dans le frigo (qte > 0)
Ecrire la recette qui affiche ce qui manque dans le frigo
Faire la page qui update les courses

```sql
Commandes MySQL :

__ Connexion à MySQL :
	sudo mysql -u root -p

__ Création de la BD : 
	show databases;
	CREATE DATABASE courses;
	show databases;
	use courses;
	show tables;

__ Création de tables :
	CREATE TABLE aliment (
		id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
		nom VARCHAR(30) NOT NULL,
		categorie VARCHAR(30),
		valeur INTEGER(3) NOT NULL,
		unite VARCHAR(10));
	CREATE TABLE recette (
		id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
		nom VARCHAR(30) NOT NULL,
		type VARCHAR(30),
		temps VARCHAR(10),
		derniere_utilisation DATE );
	CREATE TABLE instruction (
		id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
		phrase VARCHAR(255) );
	CREATE TABLE etape (
		id_recette INT NOT NULL,
		id_instruction INT NOT NULL,
		num_etape INTEGER NOT NULL,
		PRIMARY KEY (id_recette, id_instruction, num_etape),
		FOREIGN KEY (id_recette) REFERENCES recette(id) ON DELETE CASCADE,
		FOREIGN KEY (id_instruction) REFERENCES instruction(id) ON DELETE CASCADE);
	CREATE TABLE ingredient (
		id_recette INT NOT NULL,
		id_aliment INT NOT NULL,
		quantite INT NOT NULL,
		unite VARCHAR(10),
		PRIMARY KEY (id_recette, id_aliment),
		FOREIGN KEY (id_recette) REFERENCES recette(id),
		FOREIGN KEY (id_aliment) REFERENCES aliment(id));
	show columns from aliment;

__ Ajouter quelques tuples
	INSERT INTO `recette` (`nom`, `type`, `temps`) VALUES
	('Gâteau au chocolat', 'Dessert', '1 heure'),
	('Pâte à crêpe', 'Pâte', '20 min'),
	('Mojito', 'Cocktail avec alcool', '5 min');
	INSERT INTO `aliment` (`nom`, `valeur`, `unite`) VALUES 
	('Chocolat noir', 200, 'g'),
	('oeufs', 6, ''),
	('Sucre', 500, 'g'),
	('Farine', 1, 'kg'),
	('Beurre doux', 500, 'g'),
	('Extrait de vanille', 5, 'g'),
	('Levure chimique', 5, 'sachet(s)'),
	('Sucre vanillé', 5, 'sachet(s)'),
	('Lait', 1, 'litre'),
	('Sel', 200, 'g'),
	('Rhum', 20, 'cl'),
	('Menthe', 10, 'feuilles'),
	('Citron', 2, ''),
	('Eau gazeuse', 1, 'litre'),
	('Glaçon', 20, '');
	INSERT INTO `ingredient` (`id_recette`, `id_aliment`, `quantite`, `unite`) VALUES
	(3, 13, 5, 'cl'),
	(3, 15, 0.5, ''),
	(3, 16, 6, 'cl'),
	(3, 14, 7, 'feuilles'),
	(3, 11, 2, 'càc'),
	(3, 12, 4, '');
	INSERT INTO `instruction` (`phrase`) VALUES
	('Dans un verre, écrasez les feuilles de menthe au pilon dans le rhum'),
	('Ajoutez le sucre et le jus de citron et mélangez.'),
	('Terminez en rajoutant l\'eau gazeuse et les glaçons pilés.');
	INSERT INTO `etape` (`id_recette`, `id_instruction`, `num_etape`) VALUES
	(3, 1, 1),
	(3, 2, 2),
	(3, 3, 3);

__ Ecrire des requêtes
	Récupérer le nom et les proportions des ingrédients d\'une recette :
		SELECT a.nom ingredients, i.quantite, i.unite 
		FROM recette r, aliment a, ingredient i 
		WHERE r.id = i.id_recette 
			AND a.id = i.id_aliment 
			AND r.nom = 'Mojito';
	Récupérer les instructions pour la recette "Mojito" :
		SELECT e.num_etape Etape, i.phrase Instruction 
		FROM recette r, etape e, instruction i
		WHERE r.id = e.id_recette 
			AND i.id = e.id_instruction 
			AND r.nom = 'Mojito';
Récupérer la valeur des ingrédédients pour la reccette 3 :
		SELECT ing_valeur
  	FROM recette r, ingredient i
  	WHERE r.id = i.id_recette
    	AND i.id_recette = 3;
	Récupérer les aliment dans les placard :
		SELECT `nom`, `valeur`, `unite`
		FROM aliment
		WHERE `valeur` > 0
	Réqupérer les ingrédients manquants et leurs quantités :
		SELECT  a.nom, i.quantite - a.valeur as "Quantité manquante", i.unite
		FROM aliment a, recette r, ingredient i
		WHERE r.id = i.id_recette
			AND a.id = i.id_aliment
			AND r.id = 3
			AND i.quantite > a.valeur
	Mettre à jour les aliments après une recette :
		UPDATE `aliment`
		SET `valeur` = `valeur` + (
	    SELECT i.quantite
	    FROM ingredient i, aliment a, recette r
	    WHERE a.id = i.id_aliment
		    AND r.id = i.id_recette
		    AND r.id = 3
		    AND a.id = 14
	    ), `unite` = 'cl' 
			WHERE `aliment`.`id` = 14;

__ Requête pour la màjh d typle :
UPDATE `ingredient`
SET `id_recette` = '1' 
WHERE `ingredient`.`id_recette` = 3 
	AND `ingredient`.`id_aliment` = 16;
```

```php
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

<footer>
	ploup.
</footer>
</html>
```

```php
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
```

```php
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
	// echo "<input type=\"text\" name=\"hey\ value=\"" \">";
	echo "<button type=\"submit\">Afficher ma liste de courses></button>";
	echo "</form>";

	// Libérer la mémoire et la db
	$query->free();
	$db->close();
}
?>
```

```php
// connexion.php

<?php
function connexion(){
    $host = "localhost";    /* L'adresse du serveur */
    $login = "laureline";        /* Votre nom d'utilisateur */
    $password = " ";   /* Votre mot de passe */
    $base = "courses";      /* Le nom de la base */

    $db = new mysqli($host, $login, $password, $base);
    if(!$db){ die("Connexion échouée : " . $db->connect_error); }
    else{
        echo "Connexion réussie ! ".$login."<br>"; 
        return $db;
    }
}
?>
```

