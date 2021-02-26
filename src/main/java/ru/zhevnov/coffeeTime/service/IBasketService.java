package ru.zhevnov.coffeeTime.service;


import ru.zhevnov.coffeeTime.entity.Basket;
import ru.zhevnov.coffeeTime.entity.BasketItem;

import java.util.List;

public interface IBasketService {
    void addProductToBasket(int personId, int productId);

    List<BasketItem> returnListOfProductsInBasket(int idEmployee);

    void deleteItem(int idEmployee, int idProduct);

    String returnTotalCostOfTheOrder(int idEmployee, String phoneNumber);

    void cleanBasket(int idEmployee);

    void submitProductInBasket(int employeeId, int productId);

    Basket returnNewBasket();
}
