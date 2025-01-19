CREATE TABLE Rivers (
    id INT PRIMARY KEY,              -- Identificador único para cada rio
    river VARCHAR(50) NOT NULL,     -- Nome do rio
    location VARCHAR(50),            -- Localização do rio
    country_id INT,                  -- ID do país (chave estrangeira para Countries)
    category_id INT,                 -- ID da categoria (chave estrangeira para Categories)
    FOREIGN KEY (country_id) REFERENCES Country(id), -- Relacionamento com Countries
    FOREIGN KEY (category_id) REFERENCES Category(id) -- Relacionamento com Categories
);


INSERT INTO Rivers (river, location, country_id, category_id)
SELECT 
    t.nameCountry,           -- Nome do rio da TMP
    t.location,         -- Localização da TMP
    c.id AS country_id, -- ID do país da tabela Countries
    cat.id AS category_id -- ID da categoria da tabela Categories
FROM 
    Tmp t
JOIN 
    Country ON t.Country = c.Country -- Relaciona TMP com Countries pelo nome do país
JOIN 
    Category cat ON t.Category = cat.Category; -- Relaciona TMP com Categories pelo nome da categoria;


INSERT INTO Rivers (river, location, country_id, category_id)
SELECT 
    t.nameCountry AS rivers,        -- Nome do rio da TMP
    t.location,                     -- Localização da TMP
    c.id AS country_id,             -- ID do país da tabela Countries
    cat.id AS category_id           -- ID da categoria da tabela Categories
FROM 
    Tmp t
JOIN 
    Country c ON t.Country = c.Country -- Relaciona TMP com Countries pelo nome do país
JOIN 
    Category cat ON t.Category = cat.Category; -- Relaciona TMP com Categories pelo nome da categoria


CREATE TABLE Rivers (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Identificador único e auto-incrementado para cada rio
    rivers VARCHAR(50) NOT NULL,          -- Nome do rio
    location VARCHAR(50),                 -- Localização do rio
    country_id INT,                       -- ID do país (chave estrangeira para Countries)
    category_id INT,                      -- ID da categoria (chave estrangeira para Categories)
    FOREIGN KEY (country_id) REFERENCES Country(id),  -- Relacionamento com Countries
    FOREIGN KEY (category_id) REFERENCES Category(id) -- Relacionamento com Categories
);
