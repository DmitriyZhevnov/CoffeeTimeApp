package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.Order;

import java.sql.Date;
import java.util.List;

public interface IOrderService {
    void saveNewOrder(int idEmployee, String phoneNumber, String paymentType, String card, String cash);

    List<Order> returnTodayOrdersByEmployeeId(int employeeId);

    List<Order> returnAllOrdersByCommercialObjectAndDate(int idCommercialObject, Date date);

    Order returnOrderById(int id);

    void cancelOrder(int idOrder, String reason, String type);

    void changePaymentType(int idOrder, String type, String cash, String card, String reason);
}
