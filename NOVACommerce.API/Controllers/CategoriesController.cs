using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NOVACommerce.API.Data;
using NOVACommerce.API.DTOs.Categories;

namespace NOVACommerce.API.Controllers;


[ApiController]
[Route("api/[controller]")]
public class CategoriesController : ControllerBase
{
    private readonly ApplicationDbContext _context;
    public CategoriesController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult> GetCategories()
    {
        var categories = await _context.Categories.AsNoTracking().Where(c => c.IsActive).ToListAsync();
        return Ok(categories);
    }

    [HttpPost]
    public async Task<ActionResult> CreateCategory(CategoryRequestDto request)
    {
        if (string.IsNullOrWhiteSpace(request.Name))
        {
            return BadRequest("Category name is required.");
        }
        var category = new Models.Category
        {
            Name = request.Name.Trim(),
            Description = request.Description,
            ImageUrl = request.ImageUrl,
            IsActive = true,
        };

        _context.Categories.Add(category);
        await _context.SaveChangesAsync();

        return CreatedAtAction(
            nameof(GetCategories),
            new { id = category.Id }, category
        );
    }
}