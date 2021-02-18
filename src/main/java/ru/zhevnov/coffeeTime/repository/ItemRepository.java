package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.Item;

@Repository
public interface ItemRepository extends JpaRepository<Item, Integer> {
}
