SELECT
    Id,
    Name,
    ImageUrl,
    StockQuantity,
    CategoryId,
    IsActive
FROM Products
ORDER BY Id;

Select * from Products;

SELECT Id, Name, IsActive
FROM Categories
ORDER BY Id;

DELETE FROM Categories
WHERE Id IN (4);

DELETE FROM Products;

---It resets the identity counter---
DBCC CHECKIDENT ('Products', RESEED, 0);


---Insert data---
INSERT INTO Categories (Name, Description, ImageUrl, IsActive)
VALUES
('Clothing', 'Minimal everyday clothing', NULL, 1),
('Accessories', 'Essential accessories for everyday life', NULL, 1),
('Bags', 'Functional bags designed for everyday use', NULL, 1);


UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1542291026-7eec264c27ff' WHERE Id = 1;
UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77' WHERE Id = 2;
UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1549298916-b41d501d3772' WHERE Id = 3;

UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab' WHERE Id = 4;
UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1556821840-3a63f95609a7' WHERE Id = 5;
UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1551028719-00167b16eac5' WHERE Id = 6;

UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1524805444758-089113d48a6d' WHERE Id = 7;
UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1521369909029-2afed882baee' WHERE Id = 8;
UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1624222247344-550fb60583dc' WHERE Id = 9;

UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62' WHERE Id = 10;
UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1544816155-12df9643f363' WHERE Id = 11;
UPDATE Products SET ImageUrl = 'https://images.unsplash.com/photo-1622560480605-d83c853bc5c3' WHERE Id = 12;