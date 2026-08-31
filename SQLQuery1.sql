SELECT
    Id,
    Name,
    Description,
    Price,
    ImageUrl,
    
    CategoryId,
    IsActive
FROM Products;

SELECT
    Id,
    Name,
    IsActive
FROM Categories;

DELETE FROM Products
WHERE Id IN (3);



---It resets the identity counter---
DBCC CHECKIDENT ('Products', RESEED, 0);