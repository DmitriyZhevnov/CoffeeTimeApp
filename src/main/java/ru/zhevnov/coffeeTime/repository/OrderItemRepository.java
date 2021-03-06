package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.OrderItem;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Integer> {
}
