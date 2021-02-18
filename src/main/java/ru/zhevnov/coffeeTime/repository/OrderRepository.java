package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.BasketItem;
import ru.zhevnov.coffeeTime.entity.Order;

import java.sql.Date;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    @Query("from Order where shift.id in (select sh.id from Shift sh where sh.dateOpened = :date and sh.commercialObject.id = :comId and sh.employee.id = :idEmployee)")
    List<Order> returnTodayOrdersByEmployeeId(@Param("idEmployee") int idEmployee,@Param("date") Date date,@Param("comId") int comId);

    @Query("from BasketItem where basket.employee.id = :idEmployee")
    List<BasketItem> returnListOfProductsInBasket(@Param("idEmployee") int idEmployee);

    @Query("from Order where date = :date and shift.id in (select sh.id from Shift sh where sh.commercialObject.id = :comId)")
    List<Order> returnAllOrdersByCommercialObjectAndDate(@Param("comId") int idCommercialObject,@Param("date") Date date);

    Order findById(int id);
}
