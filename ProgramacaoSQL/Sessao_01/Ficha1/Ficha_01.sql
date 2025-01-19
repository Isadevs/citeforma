-- 1. Crie uma Query que apresente todos os jogadores de Portugal e Espanha.
SELECT 
    COUNT(*) AS total,
    Players.player,
    Countries.country
FROM Players
INNER JOIN Countries ON Players.country_id = Countries.id
WHERE Countries.country IN ('Portugal', 'Spain')
GROUP BY Players.player, Countries.country;

-- 2. Crie uma Query que liste todos os jogadores com idade igual ou superior a 30.
DESC Players;
SELECT 
    Players.player,
    Countries.country,
    TIMESTAMPDIFF(YEAR, Players.birthdate, CURDATE()) AS age
FROM Players
INNER JOIN Countries ON Players.country_id = Countries.id
WHERE TIMESTAMPDIFF(YEAR, Players.birthdate, CURDATE()) > 30
ORDER BY TIMESTAMPDIFF(YEAR, Players.birthdate, CURDATE()) ASC;

-- 3. Crie uma Query que apresente o total de jogadores por País.
SELECT 
    C.country, 
    COUNT(P.player) AS Jogadores
FROM Players P
INNER JOIN Countries C ON P.country_id = C.id
GROUP BY C.country;

-- 4. Crie uma Query que apresente a média de alturas dos jogadores por País.
SELECT 
    C.country, 
    AVG(P.height) AS Height
FROM Players P
INNER JOIN Countries C ON P.country_id = C.id
GROUP BY C.country
ORDER BY height;

-- 5. Crie uma Query que apresente o total de jogadores por País 
-- com o peso acima dos 60 kg.
DESC Players;

SELECT 
    C.country, 
    SUM(P.weight) AS 'Jogadores'
FROM Players P
INNER JOIN Countries C ON P.country_id = C.id
GROUP BY C.country
HAVING SUM(P.weight) >= 40
ORDER BY SUM(P.weight) ASC;

-- 6. Crie uma Query que apresente o peso máximo e o peso mínimo dos jogadores por País.
SELECT 
    C.country, 
	MIN(P.weight) AS 'Peso Mínimo Jogadores',
    MAX(P.weight) AS 'Peso Maximo Jogadores'
FROM Players P
INNER JOIN Countries C ON P.country_id = C.id
GROUP BY C.country
ORDER BY MIN(P.weight) AND MAX(P.weight) ASC;



