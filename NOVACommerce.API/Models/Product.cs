namespace NOVACommerce.API.Models;

public class Product
{
    public int Id { get; set; }
    public String Name { get; set; } = string.Empty;
    public String? Description { get; set; }
    public decimal Price { get; set; }
    public String? ImageUrl { get; set; }
    public int StockQuantity { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public int CategoryId { get; set; }
    public Category Category { get; set; } = null!;
}