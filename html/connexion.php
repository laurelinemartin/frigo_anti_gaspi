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
