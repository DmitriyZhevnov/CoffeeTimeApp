package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.zhevnov.coffeeTime.entity.CommercialObjectQuantityOfItems;

public interface CommercialObjectItemQuantityRepository extends JpaRepository<CommercialObjectQuantityOfItems, Integer> {
}
