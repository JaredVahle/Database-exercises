SELECT DISTINCT last_name
FROM employees
LIMIT 10;

/*
Facello
Simmel
Bamford
Koblick
Maliniak
Preusig
Zielinski
Kalloufi
Peac
Piveteau
*/

SELECT *
FROM employees
WHERE (hire_date LIKE "199%") AND  hire_date LIKE "%-12-25"
LIMIT 5

-- YINGHUA, STEPEHN, TIINA, UDI, GUISEPPE

