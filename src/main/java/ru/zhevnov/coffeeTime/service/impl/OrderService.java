package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.*;
import ru.zhevnov.coffeeTime.repository.OrderRepository;
import ru.zhevnov.coffeeTime.service.*;

import javax.transaction.Transactional;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@Service
public class OrderService implements IOrderService {

    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private IClientService clientService;
    @Autowired
    private IShiftService shiftService;
    @Autowired
    private IBasketService basketService;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private IProductService productService;
    @Autowired
    private IOrderItemService orderItemService;
    @Autowired
    private ICommercialObjectService commercialObjectService;


    @Transactional
    public void saveNewOrder(int idEmployee, String phoneNumber, String paymentType, String card, String cash) {
        Employee employee = employeeService.returnEmployeeById(idEmployee);
        if (!employee.getBasket().getBasketItems().isEmpty()) {
            Date date = new Date(System.currentTimeMillis());
            Time time = new Time(System.currentTimeMillis());
            Client client = clientService.returnClientByPhoneNumber(phoneNumber);
            double totalCostOfOrder;
            Order newOrder;
            Shift currentShift = shiftService.returnOpenedShiftByEmployeeId(idEmployee);
            if (client == null) {
                totalCostOfOrder = Double.parseDouble(basketService.returnTotalCostOfTheOrder(employee.getId(), ""));
                if (paymentType.equals("cash")) {
                    newOrder = new Order(date, time, totalCostOfOrder, 0.0, 0, currentShift, null, paymentType, null);
                } else if (paymentType.equals("card")) {
                    newOrder = new Order(date, time, 0.0, totalCostOfOrder, 0, currentShift, null, paymentType, null);
                } else {
                    double cashAmount = Double.parseDouble(cash);
                    double cardAmount = Double.parseDouble(card);
                    newOrder = new Order(date, time, cashAmount, cardAmount, 0, currentShift, null, paymentType, null);
                }
            } else {
                totalCostOfOrder = Double.parseDouble(basketService.returnTotalCostOfTheOrder(employee.getId(), client.getPhoneNumber()));
                if (paymentType.equals("cash")) {
                    newOrder = new Order(date, time, totalCostOfOrder, 0.0, client.getDiscount(), currentShift, client, paymentType, null);
                } else if (paymentType.equals("card")) {
                    newOrder = new Order(date, time, 0.0, totalCostOfOrder, client.getDiscount(), currentShift, client, paymentType, null);
                } else {
                    double cashAmount = Double.parseDouble(cash);
                    double cardAmount = Double.parseDouble(card);
                    newOrder = new Order(date, time, cashAmount, cardAmount, client.getDiscount(), currentShift, client, paymentType, null);
                }
                clientService.addOnePercentToDiscount(client.getId());
            }
            orderRepository.save(newOrder);
            putProductsInOrderItemFromBasketItem(employee.getId(), newOrder.getId());
            basketService.cleanBasket(employee.getId());
        }
    }

    @Transactional
    public List<Order> returnTodayOrdersByEmployeeId(int employeeId) {
        Date date = new Date(System.currentTimeMillis());
        Shift shift = shiftService.returnOpenedShiftByEmployeeId(employeeId);
        return orderRepository.returnTodayOrdersByEmployeeId(employeeId, date, shift.getCommercialObject().getId());
    }

    @Transactional
    public List<Order> returnAllOrdersByCommercialObjectAndDate(int idCommercialObject, Date date) {
        return orderRepository.returnAllOrdersByCommercialObjectAndDate(idCommercialObject, date);
    }

    @Transactional
    public Order returnOrderById(int id) {
        return orderRepository.findById(id);
    }

    @Transactional
    public void cancelOrder(int idOrder, String reason, String type) {
        Date date = new Date(System.currentTimeMillis());
        Time time = new Time(System.currentTimeMillis());
        Order order = orderRepository.getOne(idOrder);
        order.setCardAmount(0.0);
        order.setCashAmount(0.0);
        order.setPaymentType("cancelled");
        StringBuilder info;
        if (order.getInfo() == null) {
            info = new StringBuilder();
        } else {
            info = new StringBuilder(order.getInfo());
        }
        if (type.equals("withWriteOffProducts")) {
            info.append("| Отмена заказа " + date + " в " + time + " С списанием продуктов.\n Причина:" + reason + "\n");
        } else if (type.equals("withoutWriteOffProducts")) {
            info.append("| Отмена заказа " + date + " в " + time + " БЕЗ списания продуктов.\n Причина:" + reason + "\n");
            commercialObjectService.addItemsFromOrderInCommercialObjectsStorage(order.getId());
        }
        order.setInfo(info.toString());
        orderRepository.save(order);
    }

    @Transactional
    public void changePaymentType(int idOrder, String type, String cash, String card, String reason) {
        Date date = new Date(System.currentTimeMillis());
        Time time = new Time(System.currentTimeMillis());
        Order order = orderRepository.getOne(idOrder);
        StringBuilder info;
        if (order.getInfo() == null) {
            info = new StringBuilder();
        } else {
            info = new StringBuilder(order.getInfo());
        }
        info.append("| Изменение типа оплаты " + date + " в " + time + ", с " + order.getPaymentType() +
                " на " + type + ".\n Причина:" + reason + "\n");
        order.setPaymentType(type);
        double totalCost = order.getCashAmount() + order.getCardAmount();
        if (type.equals("cash")) {
            order.setCashAmount(totalCost);
            order.setCardAmount(0.0);
        } else if (type.equals("card")) {
            order.setCashAmount(0.0);
            order.setCardAmount(totalCost);
        } else if (type.equals("different")) {
            order.setCashAmount(Double.parseDouble(cash));
            order.setCardAmount(Double.parseDouble(card));
        }
        order.setInfo(info.toString());
        orderRepository.save(order);
    }

    @Transactional
    public void putProductsInOrderItemFromBasketItem(int employeeId, int orderId) {
        Employee employee = employeeService.returnEmployeeById(employeeId);
        Order order = orderRepository.getOne(orderId);
        for (BasketItem basketItem : employee.getBasket().getBasketItems()) {
            Product product = productService.returnProductById(basketItem.getProducts().get(0).getId());
            OrderItem orderItem = new OrderItem();
            orderItem.setProducts(basketItem.getProducts());
            orderItem.setQuantity(basketItem.getQuantity());
            orderItem.setOrder(order);
            product.getOrderItems().add(orderItem);
            orderItemService.saveOrUpdate(orderItem);
            productService.saveOrUpdateProduct(product);
        }
    }
}
