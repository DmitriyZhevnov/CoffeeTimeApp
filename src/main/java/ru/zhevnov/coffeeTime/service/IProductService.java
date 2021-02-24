package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.Product;

import java.util.List;

public interface IProductService {
    void saveOrUpdateProduct(Product product);

    List<Product> returnAllProducts();

    Product returnProductById(int id);

    void updateProductWithNewData(int productId, String productName, double productPrice, int categoryId);

    void updateCompositionOfProduct(int compositionId, double quantityOfItem);

    void addItemToProduct(int idProduct, int idItem);

    void removeItemFromProduct(int idProduct, int idComposition);

    Product returnNewProduct();
}
