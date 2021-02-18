package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.Category;
import ru.zhevnov.coffeeTime.entity.Product;

import java.util.List;

public interface ICategoryService {
    List<Product> returnAllCoffees();
    List<Product> returnAllDrinks();
    List<Product> returnAllAdditions();
    List<Product> returnAllBars();
    List<Category> returnAllCategories();
    Category returnById(int id);
}
