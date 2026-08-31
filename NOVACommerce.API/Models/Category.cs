namespace NOVACommerce.API.Models;

public class Category
{
    public int Id { get; set; }
    public String Name { get; set; } = string.Empty;
    public String? Description { get; set; }
    public String? ImageUrl { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public ICollection<Product> Products { get; set; } = new List<Product>();
}