using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace NOVACommerce.API.Migrations
{
    /// <inheritdoc />
    public partial class RenameStockQualityToStockQuantity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "StockQuality",
                table: "Products",
                newName: "StockQuantity");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "StockQuantity",
                table: "Products",
                newName: "StockQuality");
        }
    }
}
