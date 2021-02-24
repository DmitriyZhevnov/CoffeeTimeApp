package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.CommercialObjectQuantityOfItems;

@Repository
public interface CommercialObjectItemQuantityRepository extends JpaRepository<CommercialObjectQuantityOfItems, Integer> {
}
