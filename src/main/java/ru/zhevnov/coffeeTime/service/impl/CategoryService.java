package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Category;
import ru.zhevnov.coffeeTime.entity.Product;
import ru.zhevnov.coffeeTime.repository.CategoryRepository;
import ru.zhevnov.coffeeTime.repository.ProductRepository;
import ru.zhevnov.coffeeTime.service.ICategoryService;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class CategoryService implements ICategoryService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;

    public CategoryService(ProductRepository productRepository, CategoryRepository categoryRepository) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
    }

    @Transactional
    public List<Product> returnAllCoffees() {
        return productRepository.findAllByCategoryId(1);
    }

    @Transactional
    public List<Product> returnAllDrinks() {
        return productRepository.findAllByCategoryId(2);
    }

    @Transactional
    public List<Product> returnAllAdditions() {
        return productRepository.findAllByCategoryId(3);
    }

    @Transactional
    public List<Product> returnAllBars() {
        return productRepository.findAllByCategoryId(4);
    }

    @Transactional
    public List<Category> returnAllCategories() {
        return categoryRepository.findAll();
    }

    @Transactional
    public Category returnById(int id) {
        return categoryRepository.getOne(id);
    }
}
