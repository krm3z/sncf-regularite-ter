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

-- 3. Taux de régularité de l'ancienne région Auvergne-Rhône-Alpes, de 2013 à 2017
-- Avant la fusion, la région est séparée en 'Rhône Alpes' et 'Auvergne' : on additionne les trains des deux,
-- au lieu de faire la moyenne des taux, car Rhône Alpes fait rouler 6 fois plus de trains
-- Résultat : entre 87,9 % et 89,7 %, sous le niveau de 2019-2025
SELECT annee, ROUND(100.0 * (SUM(trains_circules) - SUM(trains_retard)) / SUM(trains_circules), 2) AS taux
FROM ter
WHERE region IN ('Auvergne', 'Rhône Alpes')
GROUP BY annee;

-- 4. Taux de régularité d'Auvergne-Rhône-Alpes sur toute la période, de 2013 à 2026
-- On réunit les trois noms de la région (Auvergne et Rhône Alpes avant 2018, Auvergne-Rhône-Alpes après)
-- et on calcule le taux à partir des sommes de trains, pour toutes les années de la même façon
-- Résultat : stable autour de 88-89 % jusqu'en 2018, pic à 92,7 % en 2021, puis retour vers 89-90 %
-- Remarque : en 2020, la moyenne des mois (AVG) donnait 92,58 % contre 92,21 % ici,
-- car les mois Covid avec peu de trains pesaient trop lourd
SELECT annee, ROUND(100.0 * (SUM(trains_circules) - SUM(trains_retard)) / SUM(trains_circules), 2) AS taux
FROM ter
WHERE region IN ('Auvergne', 'Rhône Alpes', 'Auvergne-Rhône-Alpes')
GROUP BY annee;