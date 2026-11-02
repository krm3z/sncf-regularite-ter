-- Projet : régularité des TER en Auvergne-Rhône-Alpes
-- Données : Régularité mensuelle TER, SNCF (data.gouv.fr), janvier 2013 à août 2026
-- Table : ter (une ligne par région et par mois)


-- 1. Taux de régularité moyen d'Auvergne-Rhône-Alpes par année
-- La région n'existe dans les données qu'à partir de 2018 (avant : Rhône Alpes et Auvergne séparées)
-- Résultat : montée jusqu'à 92,7 % en 2021, puis baisse jusqu'à 89,4 % en 2026 (8 mois seulement)
SELECT annee, ROUND(AVG(taux_regularite), 2) AS taux_moyen
FROM ter
WHERE region = 'Auvergne-Rhône-Alpes'
GROUP BY annee;


-- 2. Même calcul pour la Bretagne, pour comparer
-- Résultat : autour de 95 % chaque année, soit environ 5 points de plus qu'Auvergne-Rhône-Alpes
SELECT annee, ROUND(AVG(taux_regularite), 2) AS taux_moyen
FROM ter
WHERE region = 'Bretagne'
GROUP BY annee;
