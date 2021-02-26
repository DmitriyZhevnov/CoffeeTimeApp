package ru.zhevnov.coffeeTime.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.entity.Product;
import ru.zhevnov.coffeeTime.service.ICategoryService;
import ru.zhevnov.coffeeTime.service.IItemService;
import ru.zhevnov.coffeeTime.service.IProductService;

@Controller
@SessionAttributes({"user"})
@RequestMapping("/menu")
public class MenuController {

    private final IProductService productService;
    private final ICategoryService categoryService;
    private final IItemService itemService;

    public MenuController(IProductService productService, ICategoryService categoryService, IItemService itemService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.itemService = itemService;
    }

    @GetMapping
    public String showMenu(@ModelAttribute("user") Employee employee, Model model) {
        model.addAttribute("allProducts", productService.returnAllProducts());
        return "main/menu/menuPage";
    }

    @GetMapping("/{idProduct}")
    public String editProduct(@PathVariable(name = "idProduct") int idProduct,
                              @ModelAttribute("user") Employee employee, Model model) {
        model.addAttribute("allCategories", categoryService.returnAllCategories());
        Product product = productService.returnProductById(idProduct);
        model.addAttribute("product", product);
        model.addAttribute("composition", product.getComposition());
        model.addAttribute("items", itemService.returnAllItems());
        return "main/menu/editProduct";
    }

    @PatchMapping("/update")
    public String updateProduct(@ModelAttribute("user") Employee employee, @RequestParam("productId") int productId,
                                @RequestParam("productName") String productName,
                                @RequestParam("productPrice") String productPrice,
                                @RequestParam("idCategory") String categoryId) {
        try {
            if (!categoryId.isEmpty()) {
                productService.updateProductWithNewData(productId, productName, Double.parseDouble(productPrice),
                        Integer.parseInt(categoryId));
            }
        } catch (NumberFormatException e) {
        }
        return "redirect:/menu/" + productId;
    }

    @PatchMapping("/updateComposition")
    public String updateComposition(@RequestParam("compositionId") int compositionId,
                                    @RequestParam("quantityOfItem") String quantityOfItem,
                                    @RequestParam("productId") int productId) {
        try {
            productService.updateCompositionOfProduct(compositionId, Double.parseDouble(quantityOfItem));
        } catch (NumberFormatException e) {
        }
        return "redirect:/menu/" + productId;
    }

    @PostMapping("/{idProduct}/addItem")
    public String addItemToProduct(@PathVariable(name = "idProduct") int idProduct,
                                   @RequestParam(value = "idItem", required = false) String idItem) {
        if (idItem != null) {
            productService.addItemToProduct(idProduct, Integer.parseInt(idItem));
        }
        return "redirect:/menu/" + idProduct;
    }

    @DeleteMapping("/{idProduct}/removeItem")
    public String removeItemFromProduct(@PathVariable(name = "idProduct") int idProduct,
                                        @RequestParam("compositionId") int idComposition) {
        productService.removeItemFromProduct(idProduct, idComposition);
        return "redirect:/menu/" + idProduct;
    }

    @PostMapping("/newItem")
    public String saveNewItem(@RequestParam("idProduct") int idProduct, @RequestParam("name") String itemName,
                              @RequestParam("measure") String itemMeasure,
                              @RequestParam("quantityInWarehouse") String itemQuantityInWarehouse) {
        try {
            itemService.addNewItem(itemName, itemMeasure, Double.parseDouble(itemQuantityInWarehouse));
        } catch (NumberFormatException e) {
        }
        return "redirect:/menu/" + idProduct;
    }

    @GetMapping("/newProduct")
    public String newProduct() {
        return "redirect:/menu/" + productService.returnNewProduct().getId();
    }
}
