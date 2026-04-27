-- ============================================================
-- PROJET : Analyse du prix du SP95 en Île-de-France
-- Auteur  : Haroun Elias
-- Source  : Données gouvernementales ouvertes (data.gouv.fr)
-- ============================================================

-- Requête principale : stations triées par distance
-- depuis un point de référence en Île-de-France
-- avec filtre sur les départements IDF (75, 77, 78, 91, 92, 93, 94, 95)

SELECT
  adresse,
  ville,
  CONCAT(adresse, " ", code_postal, " ", ville) AS adresse_complete,
  ROUND(prix_sp95, 2) AS prix_sp95,
  ROUND(
    ST_DISTANCE(
      ST_GEOGPOINT(2.4211983333333333, 48.8514811),
      ST_GEOGPOINT(longitude, latitude)
    ) / 1000, 1
  ) AS distance_in_kms
FROM `fr_carburants.fr_carburant`
WHERE code_departement IN ("75","77","78","91","92","93","94","95")
  AND prix_sp95 IS NOT NULL
ORDER BY distance_in_kms ASC
