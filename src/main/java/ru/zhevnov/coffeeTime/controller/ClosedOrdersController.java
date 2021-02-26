package ru.zhevnov.coffeeTime.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IOrderService;

import java.sql.Date;

@Controller
@SessionAttributes({"user"})
@RequestMapping("/closedOrders")
public class ClosedOrdersController {

    private final IOrderService orderService;
    private final ICommercialObjectService commercialObjectService;

    public ClosedOrdersController(IOrderService orderService, ICommercialObjectService commercialObjectService) {
        this.orderService = orderService;
        this.commercialObjectService = commercialObjectService;
    }

    @GetMapping()
    public String showCanceledOrders(@ModelAttribute("user") Employee employee, Model model) {
        model.addAttribute("date", new Date(System.currentTimeMillis()));
        model.addAttribute("allCommercialObjects", commercialObjectService.returnAllCommercialObjects());
        model.addAttribute("orders", orderService.returnTodayOrdersByEmployeeId(employee.getId()));
        return "main/orders/closedOrders";
    }

    @PostMapping("/date")
    public String showCanceledOrdersForAdmin(@ModelAttribute("user") Employee employee, Model model,
                                             @RequestParam("idCommercialObject") int idCommercialObject,
                                             @RequestParam("date") Date date) {
        model.addAttribute("date", new Date(System.currentTimeMillis()));
        model.addAttribute("allCommercialObjects", commercialObjectService.returnAllCommercialObjects());
        model.addAttribute("orders", orderService.returnAllOrdersByCommercialObjectAndDate(idCommercialObject, date));
        return "main/orders/closedOrders";
    }

    @GetMapping("/{idOrder}")
    public String showOrderInfo(@PathVariable(name = "idOrder") int idOrder,
                                @ModelAttribute("user") Employee employee, Model model) {
        model.addAttribute("order", orderService.returnOrderById(idOrder));
        return "main/orders/ordersInfo";
    }

    @PatchMapping("/{idOrder}/cancel")
    public String cancelOrder(@PathVariable(name = "idOrder") int idOrder, @RequestParam(name = "reason") String reason,
                              @RequestParam(name = "typeOfOrderCancellation") String type, Model model) {
        if (orderService.returnOrderById(idOrder).getPaymentType().equals("cancelled")) {
            model.addAttribute("msg", "Заказ уже был отменён.");
        } else {
            orderService.cancelOrder(idOrder, reason, type);
        }
        model.addAttribute("order", orderService.returnOrderById(idOrder));
        return "main/orders/ordersInfo";
    }

    @PatchMapping("/{idOrder}/changePaymentType")
    public String changePaymentType(@PathVariable(name = "idOrder") int idOrder,
                                    @RequestParam(name = "reason", required = false) String reason,
                                    @RequestParam(name = "paymentType") String type,
                                    @RequestParam(value = "cashAmount", required = false) String cash,
                                    @RequestParam(value = "cardAmount", required = false) String card, Model model) {
        if (orderService.returnOrderById(idOrder).getPaymentType().equals("cancelled")) {
            model.addAttribute("msg", "Тип оплаты изменить нельзя, так как заказ был отменён.");
            model.addAttribute("order", orderService.returnOrderById(idOrder));
            return "main/orders/ordersInfo";
        } else {
            if (type.equals("different")) {
                try {
                    if (Double.parseDouble(cash) < 0 || Double.parseDouble(card) < 0) {
                        model.addAttribute("msg", "Ошибка. Введите сумму корректно");
                    } else {
                        orderService.changePaymentType(idOrder, type, cash, card, reason);
                    }
                } catch (
                        NumberFormatException e) {
                    model.addAttribute("msg", "Ошибка. Введите сумму корректно");
                } finally {
                    model.addAttribute("order", orderService.returnOrderById(idOrder));
                    return "main/orders/ordersInfo";
                }
            } else {
                orderService.changePaymentType(idOrder, type, cash, card, reason);
            }
            model.addAttribute("order", orderService.returnOrderById(idOrder));
            return "main/orders/ordersInfo";
        }
    }
}
