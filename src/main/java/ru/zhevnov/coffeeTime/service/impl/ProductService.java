package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Category;
import ru.zhevnov.coffeeTime.entity.Composition;
import ru.zhevnov.coffeeTime.entity.Item;
import ru.zhevnov.coffeeTime.entity.Product;
import ru.zhevnov.coffeeTime.repository.ProductRepository;
import ru.zhevnov.coffeeTime.service.ICategoryService;
import ru.zhevnov.coffeeTime.service.ICompositionService;
import ru.zhevnov.coffeeTime.service.IItemService;
import ru.zhevnov.coffeeTime.service.IProductService;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class ProductService implements IProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private ICompositionService compositionService;
    @Autowired
    private IItemService itemService;

    @Transactional
    public void saveOrUpdateProduct(Product product) {
        productRepository.save(product);
    }

    @Transactional
    public List<Product> returnAllProducts() {
        return productRepository.findAll();
    }

    @Transactional
    public Product returnProductById(int id) {
        return productRepository.getOne(id);
    }

    @Transactional
    public void updateProductWithNewData(int productId, String productName, double productPrice, int categoryId) {
        Product product = productRepository.getOne(productId);
        Category category = categoryService.returnById(categoryId);
        product.setCategory(category);
        product.setPrice(productPrice);
        product.setName(productName);
        productRepository.save(product);
    }

    @Transactional
    public void updateCompositionOfProduct(int compositionId, double quantityOfItem) {
        Composition composition = compositionService.returnById(compositionId);
        composition.setQuantity(quantityOfItem);
        compositionService.saveOrUpdate(composition);
    }

    @Transactional
    public void addItemToProduct(int idProduct, int idItem) {
        Product product = productRepository.getOne(idProduct);
        Composition composition = new Composition();
        composition.setItem(itemService.returnItemById(idItem));
        product.getComposition().add(composition);
        compositionService.saveOrUpdate(composition);
        productRepository.save(product);

    }

    @Transactional
    public void removeItemFromProduct(int idProduct, int idComposition) {
        Product product = productRepository.getOne(idProduct);
        Composition composition = compositionService.returnById(idComposition);
        product.getComposition().remove(composition);
        productRepository.save(product);
        compositionService.removeComposition(composition);
    }

    @Transactional
    public Product returnNewProduct() {
        Product product = new Product();
        productRepository.save(product);
        return product;
    }
}
