package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
}
