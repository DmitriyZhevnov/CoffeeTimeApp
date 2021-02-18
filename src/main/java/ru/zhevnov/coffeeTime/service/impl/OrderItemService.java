package ru.zhevnov.coffeeTime.service.impl;

import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Order;
import ru.zhevnov.coffeeTime.entity.OrderItem;
import ru.zhevnov.coffeeTime.entity.Shift;
import ru.zhevnov.coffeeTime.repository.OrderItemRepository;
import ru.zhevnov.coffeeTime.service.IOrderItemService;

import javax.transaction.Transactional;
import java.sql.Date;
import java.util.List;

@Service
public class OrderItemService implements IOrderItemService {

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Transactional
    public void saveOrUpdate(OrderItem orderItem) {
        orderItemRepository.save(orderItem);
    }

}
