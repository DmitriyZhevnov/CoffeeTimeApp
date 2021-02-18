package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.BasketItem;

@Repository
public interface BasketItemRepository extends JpaRepository<BasketItem, Integer> {
}
