package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.OrderItem;
import ru.zhevnov.coffeeTime.repository.OrderItemRepository;
import ru.zhevnov.coffeeTime.service.IOrderItemService;

import javax.transaction.Transactional;

@Service
public class OrderItemService implements IOrderItemService {

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Transactional
    public void saveOrUpdate(OrderItem orderItem) {
        orderItemRepository.save(orderItem);
    }

}
