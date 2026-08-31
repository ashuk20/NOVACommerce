namespace NOVACommerce.API.DTOs.Products;

public class ProductRequestDto
{
    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    public decimal Price { get; set; }
    public string? ImageUrl { get; set; }
    public int StockQuality { get; set; }

    public int CategoryId { get; set; }

}