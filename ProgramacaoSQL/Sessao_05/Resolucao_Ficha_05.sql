-- EX_001

USE SalmonRiver;

SELECT r.rivers AS river_name, c.Country AS country_name
FROM Rivers r
JOIN Country c ON r.country_id = c.id
WHERE c.Country LIKE 'EU-%';

-- EX_002
SELECT 
    c.Country AS country_name, 
    COUNT(r.id) AS total_rivers
FROM 
    Rivers r
JOIN 
    Country c ON r.country_id = c.id
GROUP BY 
    c.Country
ORDER BY 
    total_rivers DESC;
    
-- Ex_003
SELECT 
    c.Country AS country_name, 
    COUNT(r.id) AS total_rivers
FROM 
    Rivers r
JOIN 
    Country c ON r.country_id = c.id
GROUP BY 
    c.Country
HAVING 
    COUNT(r.id) > 100
ORDER BY 
    total_rivers DESC;

-- EX_004 
SELECT 
    c.Country AS country_name, 
    COUNT(r.id) AS total_rivers
FROM 
    Rivers r
JOIN 
    Country c ON r.country_id = c.id
JOIN 
    Category cat ON r.category_id = cat.id
WHERE 
    cat.Category = 'Maintained'
GROUP BY 
    c.Country
ORDER BY 
    total_rivers DESC;
    






