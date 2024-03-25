-- Extract JSON object

SELECT * FROM superstore_db.items
WHERE properties -> "$.gluten_free"=1;

SELECT * FROM superstore_db.items
WHERE isnull(properties -> "$.gluten_free");

SELECT * FROM superstore_db.items
WHERE properties -> "$.color"="blue";

-- alternative way
SELECT * FROM superstore_db.items
WHERE JSON_EXTRACT(properties,"$.color")="blue";

-- spatial datatype
SELECT *, ST_AsText(location) FROM sakila.address;