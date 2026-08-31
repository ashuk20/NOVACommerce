using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NOVACommerce.API.Data;
using NOVACommerce.API.DTOs.Products;

namespace NOVACommerce.API.Controllers;


[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    public ProductsController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<ProductResponseDto>>> GetProducts()
    {
        var products = await _context.Products.AsNoTracking().Include(p => p.Category).Select(p => new ProductResponseDto { Id = p.Id, Name = p.Name, Description = p.Description, Price = p.Price, ImageUrl = p.ImageUrl, StockQuantity = p.StockQuantity, CategoryId = p.CategoryId, CategoryName = p.Category.Name }).ToListAsync();
        return Ok(products);

    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<ProductResponseDto>> GetProduct(int id)
    {
        var product = await _context.Products.AsNoTracking().Include(p => p.Category).Where(p => p.Id == id).Select(p => new ProductResponseDto { Id = p.Id, Name = p.Name, Description = p.Description, Price = p.Price, ImageUrl = p.ImageUrl, StockQuantity = p.StockQuantity, CategoryId = p.CategoryId, CategoryName = p.Category.Name }).FirstOrDefaultAsync();

        if (product == null)
        {
            return NotFound();
        }
        return Ok(product);
    }

    [HttpPost]
    public async Task<ActionResult<ProductResponseDto>> CreateProduct(ProductRequestDto request)
    {
        if (string.IsNullOrWhiteSpace(request.Name))
        {
            return BadRequest("Product name is required.");
        }

        if (request.Price < 0)
        {
            return BadRequest("Price can not be nagative.");
        }

        if (request.StockQuantity < 0)
        {
            return BadRequest("Stock quantity cannot be nagative.");
        }

        var categoryExists = await _context.Categories.AnyAsync(c => c.Id == request.CategoryId && c.IsActive);

        if (!categoryExists)
        {
            return BadRequest("Category does not exist.");
        }
        var product = new Models.Product
        {
            Name = request.Name.Trim(),
            Description = request.Description,
            Price = request.Price,
            ImageUrl = request.ImageUrl,
            StockQuantity = request.StockQuantity,
            CategoryId = request.CategoryId,
        };

        _context.Products.Add(product);

        await _context.SaveChangesAsync();

        var response = await _context.Products.AsNoTracking().Include(p => p.Category).Where(p => p.Id == product.Id).Select(p => new ProductResponseDto { Id = p.Id, Name = p.Name, Description = p.Description, Price = p.Price, ImageUrl = p.ImageUrl, StockQuantity = p.StockQuantity, CategoryId = p.CategoryId, CategoryName = p.Category.Name }).FirstAsync();

        return CreatedAtAction(nameof(GetProduct), new { id = product.Id }, response);
    }
}