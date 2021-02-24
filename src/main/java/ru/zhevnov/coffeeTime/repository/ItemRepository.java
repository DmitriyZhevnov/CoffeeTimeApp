package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.BasketItem;
import ru.zhevnov.coffeeTime.entity.Item;

import java.util.List;

@Repository
public interface ItemRepository extends JpaRepository<Item, Integer> {

    @Query(value = "from Item it where it not in (select i from Item i join i.commercialObjectQuantityOfItems co where co.commercialObject.id = :idCommercialObject)")
    List<Item> returnItemsForCommercialObject(@Param("idCommercialObject") int idCommercialObject);

    @Query(value = "from BasketItem where basket.employee.id = :idEmployee")
    List<BasketItem> returnListOfProductsInBasket(@Param("idEmployee") int idEmployee);
}
