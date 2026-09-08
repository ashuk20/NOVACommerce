
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NOVACommerce.API.Data;
using NOVACommerce.API.DTOs.Orders;
using NOVACommerce.API.Models;
using static NOVACommerce.API.DTOs.Orders.OrderResponseDto;


namespace NOVACommerce.API.Controllers;

[ApiController]
[Route("api/[controller]")]

public class OrdersController : ControllerBase
{
    private readonly ApplicationDbContext _context;


    public OrdersController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<ActionResult<OrderResponseDto>> CreateOrder(CreateOrderRequestDto request)
    {
        Console.WriteLine($"Customer name :{request.CustomerName}");
        if (string.IsNullOrWhiteSpace(request.CustomerName))
        {
            return BadRequest("Customer name is required.");
        }

        if (string.IsNullOrWhiteSpace(request.Email))
        {
            return BadRequest("Email is required");
        }

        if (string.IsNullOrWhiteSpace(request.Phone))
        {
            return BadRequest("Phone is required");
        }
        if (string.IsNullOrWhiteSpace(request.Address))
        {
            return BadRequest("Address is required");
        }

        if (request.Items == null || request.Items.Count == 0)
        {
            return BadRequest("Order must contain at least one item.");
        }

        if (request.Items.Any(i => i.Quantity <= 0))
        {
            return BadRequest("Quantity must be greater than zero.");
        }

        var productIds = request.Items.Select(i => i.ProductId).Distinct().ToList();

        var products = await _context.Products.Where(p => productIds.Contains(p.Id) && p.IsActive).ToListAsync();


        if (products.Count != productIds.Count)
        {
            return BadRequest("One or more products do not exist or are inactive.");
        }

        foreach (var item in request.Items)
        {
            var product = products.First(p => p.Id == item.ProductId);

            if (item.Quantity > product.StockQuantity)
            {
                return BadRequest($"Insufficient stock for product '{product.Name}'.");
            }
        }

        var order = new Order
        {
            OrderName = $"NOVA-{DateTime.UtcNow:yyyyMMddHHmmssfff}",
            CustomerName = request.CustomerName.Trim(),
            Email = request.Email.Trim(),
            Phone = request.Phone.Trim(),
            Address = request.Address.Trim(),
            City = request.City.Trim(),
            State = request.State.Trim(),
            PostalCode = request.PostalCode.Trim(),
            Status = "Padding"
        };

        decimal subtotal = 0;
        foreach (var item in request.
        s)
        {
            var product = products.First(p => p.Id == item.ProductId);

            var totalPrice = product.Price * item.Quantity;

            order.Items.Add(new OrderItem
            {
                ProductId = product.Id,
                ProductName = product.Name,
                UnitPrice = product.Price,
                Quantity = item.Quantity,
                TotalPrice = totalPrice
            });

            subtotal += totalPrice;
            product.StockQuantity -= item.Quantity;
        }

        order.Subtotal = subtotal;
        order.Total = subtotal;

        _context.Orders.Add(order);
        await _context.SaveChangesAsync();

        var response = new OrderResponseDto
        {
            Id = order.Id,
            OrderNumber = order.OrderName,
            CustomerName = order.CustomerName,
            Email = order.Email,
            Phone = order.Phone,
            Address = order.Address,
            City = order.City,
            State = order.State,
            PostalCode = order.PostalCode,
            Subtotal = order.Subtotal,
            Total = order.Total,
            Status = order.Status,
            CreatedAt = order.CreatedAt,
            Items = order.Items.Select(item => new OrderItemResponseDto
            {
                ProductId = item.ProductId,
                ProductName = item.ProductName,
                UnitPrice = item.UnitPrice,
                Quantity = item.Quantity,
                TotalPrice = item.TotalPrice,
            }).ToList()
        };
        return CreatedAtAction(nameof(GetOrder), new { id = order.Id }, response);

    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<OrderResponseDto>> GetOrder(int id)
    {
        var order = await _context.Orders.AsNoTracking().Include(o => o.Items).FirstOrDefaultAsync(o => o.Id == id);
        if (order == null)
        {
            return NotFound();
        }
        var response = new OrderResponseDto
        {
            Id = order.Id,
            OrderNumber = order.OrderName,
            CustomerName = order.CustomerName,
            Email = order.Email,
            Phone = order.Phone,
            Address = order.Address,
            City = order.City,
            State = order.State,
            PostalCode = order.PostalCode,
            Subtotal = order.Subtotal,
            Total = order.Total,
            Status = order.Status,
            CreatedAt = order.CreatedAt,
            Items = order.Items.Select(item => new OrderItemResponseDto
            {
                ProductId = item.ProductId,
                ProductName = item.ProductName,
                UnitPrice = item.UnitPrice,
                Quantity = item.Quantity,
                TotalPrice = item.TotalPrice,
            }).ToList()
        };
        return Ok(response);
    }
}