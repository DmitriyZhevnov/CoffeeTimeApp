package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.OrderItem;

public interface IOrderItemService {
    void saveOrUpdate(OrderItem orderItem);
}
