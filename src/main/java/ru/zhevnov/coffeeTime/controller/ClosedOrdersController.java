package ru.zhevnov.coffeeTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private IOrderService orderService;
    @Autowired
    private ICommercialObjectService commercialObjectService;

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
    public String showOrderInfo(@PathVariable(name = "idOrder") int idOrder,@ModelAttribute("user") Employee employee , Model model){
        model.addAttribute("order", orderService.returnOrderById(idOrder));
        return "main/orders/ordersInfo";
    }
    @PostMapping("/{idOrder}/cancel")
    public String cancelOrder(@PathVariable(name = "idOrder") int idOrder, @RequestParam(name = "reason")String reason,
                              @RequestParam(name = "typeOfOrderCancellation") String type, Model model){
        orderService.cancelOrder(idOrder, reason, type);
        model.addAttribute("order", orderService.returnOrderById(idOrder));
        return "main/orders/ordersInfo";
    }

    @PostMapping("/{idOrder}/changePaymentType")
    public String changePaymentType(@PathVariable(name = "idOrder") int idOrder,
                                    @RequestParam(name = "reason", required = false)String reason, @RequestParam(name = "paymentType") String type,
                                    @RequestParam(value = "cashAmount", required = false) String cash,
                                    @RequestParam(value = "cardAmount", required = false) String card, Model model){
        orderService.changePaymentType(idOrder, type, cash, card, reason);
        model.addAttribute("order", orderService.returnOrderById(idOrder));
        return "main/orders/ordersInfo";
    }

}
