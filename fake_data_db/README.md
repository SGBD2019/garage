- Importer la DB avec les données (dossier db)
- Logos dispos pour chaque marque dans le dossier logos (champ logo ajouté dansla table marque avec le nom du fichier)
- table depot_vente vide à ce stade

# Regénération des data
* Respecter la structure des fichiers actuelle
* Lancer les scripts PHP dans l'ordre (de 1 à 4)
* Vérifier

```sql
USE sgbd_garage;

SELECT * from marque;
SELECT * from modele;
SELECT * from personne;

SELECT * FROM vehicule
INNER JOIN modele ON vehicule.FK_modele = modele.id
INNER JOIN marque ON modele.FK_marque = marque.id
WHERE marque.name = 'Toyota';

SELECT * FROM vehicule
INNER JOIN modele ON vehicule.FK_modele = modele.id
INNER JOIN marque ON modele.FK_marque = marque.id
WHERE marque.name = 'volkswagen';

SELECT * FROM vehicule
INNER JOIN modele ON vehicule.FK_modele = modele.id
INNER JOIN marque ON modele.FK_marque = marque.id
WHERE marque.name = 'audi';
```
