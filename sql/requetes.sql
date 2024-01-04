Fichier à titre indicatif, mis en .sql pour un meilleur affichage dans l IDE
  
  
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
