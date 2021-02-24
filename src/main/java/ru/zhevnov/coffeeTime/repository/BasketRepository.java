package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.Basket;
import ru.zhevnov.coffeeTime.entity.BasketItem;

import java.util.List;

@Repository
public interface BasketRepository extends JpaRepository<Basket, Integer> {
    @Query(value = "from BasketItem where basket.employee.id = :idEmployee")
    List<BasketItem> returnListOfProductsInBasket(@Param("idEmployee") int idEmployee);
}
