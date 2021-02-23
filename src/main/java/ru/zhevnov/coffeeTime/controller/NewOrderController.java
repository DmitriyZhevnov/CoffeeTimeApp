package ru.zhevnov.coffeeTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.entity.Client;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.entity.Product;
import ru.zhevnov.coffeeTime.service.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@SessionAttributes({"user", "phoneNumber", "coffees", "drinks", "additions", "bars"})
@RequestMapping("/newOrder")
public class NewOrderController {

    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IBasketService basketService;
    @Autowired
    private IClientService clientService;
    @Autowired
    private ICommercialObjectService commercialObjectService;
    @Autowired
    private IOrderService orderService;
    @Autowired
    private MessageSource messageSource;


    @GetMapping()
    public String newOrder(HttpSession session, @RequestParam(value = "phoneNumber", required = false) String phoneNumber, Model model, @ModelAttribute("user") Employee employee) {
        model.addAttribute("totalCost", basketService.returnTotalCostOfTheOrder(employee.getId(), phoneNumber));
        model.addAttribute("basket", basketService.returnListOfProductsInBasket(employee.getId()));
        return "main/newOrder/newOrder";
    }

    @GetMapping("/add/{idProduct}")
    public String addProduct(@RequestParam(value = "phoneNumber", required = false) String phoneNumber, @PathVariable(name = "idProduct") int idProduct, Model model, @ModelAttribute("user") Employee employee) {
        basketService.addProductToBasket(employee.getId(), idProduct);
        return "redirect:/newOrder";
    }

    @GetMapping("/sub/{idProduct}")
    public String subProduct(@RequestParam(value = "phoneNumber", required = false) String phoneNumber, @PathVariable(name = "idProduct") int idProduct, Model model, @ModelAttribute("user") Employee employee) {
        basketService.submitProductInBasket(employee.getId(), idProduct);
        return "redirect:/newOrder";
    }

    @GetMapping("/delete/{idProduct}")
    public String deleteProduct(@RequestParam(value = "phoneNumber", required = false) String phoneNumber, @PathVariable(name = "idProduct") int idProduct, Model model, @ModelAttribute("user") Employee employee) {
        basketService.deleteItem(employee.getId(), idProduct);
        return "redirect:/newOrder";
    }

    @PostMapping("/makeDiscount")
    public String makeDiscount(@RequestParam(value = "phoneNumber", required = false) String phoneNumber, Model model, @ModelAttribute("user") Employee employee) {
        model.addAttribute("phoneNumber", phoneNumber);
        if (clientService.returnClientByPhoneNumber(phoneNumber) == null) {
            String errorMessage = messageSource.getMessage("newOrder.clientNotFound", new Object[]{"newOrder.clientNotFound"}, LocaleContextHolder.getLocale());
            model.addAttribute("msg", errorMessage);
        }
        model.addAttribute("totalCost", basketService.returnTotalCostOfTheOrder(employee.getId(), phoneNumber));
        model.addAttribute("basket", basketService.returnListOfProductsInBasket(employee.getId()));
        return "main/newOrder/newOrder";
    }


    @PostMapping("/newClient")
    public String registerNewClient(Model model, @RequestParam(value = "pNumber") String phoneNumber, @RequestParam("name") String name, @ModelAttribute("user") Employee employee) {
        String pattern = "^(\\+375|80)(29|25|44|33)(\\d{7})$";
        if (name.isEmpty()) {
            String errorMessage = messageSource.getMessage("newOrder.enterClientName", new Object[]{"newOrder.enterClientName"}, LocaleContextHolder.getLocale());
            model.addAttribute("msg", errorMessage);
        } else {
            if (Pattern.compile(pattern).matcher(phoneNumber).matches()) {
                if (!clientService.registerNewClient(name, phoneNumber)) {
                    String errorMessage = messageSource.getMessage("newOrder.clientExist", new Object[]{"newOrder.clientExist"}, LocaleContextHolder.getLocale());
                    model.addAttribute("msg", errorMessage);
                }
                model.addAttribute("phoneNumber", phoneNumber);
            } else {
                String errorMessage = messageSource.getMessage("newOrder.phoneNumberInvalid", new Object[]{"newOrder.phoneNumberInvalid"}, LocaleContextHolder.getLocale());
                model.addAttribute("msg", errorMessage);
            }
        }
        model.addAttribute("totalCost", basketService.returnTotalCostOfTheOrder(employee.getId(), phoneNumber));
        model.addAttribute("basket", basketService.returnListOfProductsInBasket(employee.getId()));
        return "main/newOrder/newOrder";
    }


    //
    @PostMapping("/pay")
    public String payAndMakeOrder(@RequestParam("paymentType") String paymentType, @ModelAttribute("user") Employee
            employee,
                                  @ModelAttribute("phoneNumber") String phoneNumber,
                                  @RequestParam(value = "cashAmount", required = false) String cash,
                                  @RequestParam(value = "cardAmount", required = false) String card, Model model) {
        if (paymentType.equals("different")) {
            try {
                if (Double.parseDouble(cash) < 0 || Double.parseDouble(card) < 0) {
                    String errorMessage = messageSource.getMessage("newOrder.error", new Object[]{"newOrder.error"}, LocaleContextHolder.getLocale());
                    model.addAttribute("msg", errorMessage);
                    model.addAttribute("totalCost", basketService.returnTotalCostOfTheOrder(employee.getId(), phoneNumber));
                    model.addAttribute("basket", basketService.returnListOfProductsInBasket(employee.getId()));
                    return "main/newOrder/newOrder";
                }
            } catch (NumberFormatException e) {
                String errorMessage = messageSource.getMessage("newOrder.error", new Object[]{"newOrder.error"}, LocaleContextHolder.getLocale());
                model.addAttribute("msg", errorMessage);
                model.addAttribute("totalCost", basketService.returnTotalCostOfTheOrder(employee.getId(), phoneNumber));
                model.addAttribute("basket", basketService.returnListOfProductsInBasket(employee.getId()));
                return "main/newOrder/newOrder";
            }
        }
        try {
            commercialObjectService.submitItemsFromCommercialObjectsStorage(employee.getId());
            orderService.saveNewOrder(employee.getId(), phoneNumber, paymentType, card, cash);
        } catch (IndexOutOfBoundsException e) {
            String errorMessage = messageSource.getMessage("newOrder.notAvailable", new Object[]{"newOrder.notAvailable"}, LocaleContextHolder.getLocale());
            model.addAttribute("msg", errorMessage);
            model.addAttribute("totalCost", basketService.returnTotalCostOfTheOrder(employee.getId(), phoneNumber));
            model.addAttribute("basket", basketService.returnListOfProductsInBasket(employee.getId()));
            return "main/newOrder/newOrder";
        }
        model.addAttribute("phoneNumber", "");
        return "redirect:/newOrder";
    }

    @ModelAttribute("coffees")
    public List<Product> allCoffees(Model model) {
        return categoryService.returnAllCoffees();
    }

    @ModelAttribute("drinks")
    public List<Product> allDrinks(Model model) {
        return categoryService.returnAllDrinks();
    }

    @ModelAttribute("additions")
    public List<Product> allAdditions(Model model) {
        return categoryService.returnAllAdditions();
    }

    @ModelAttribute("bars")
    public List<Product> allBars(Model model) {
        return categoryService.returnAllBars();
    }

    @ModelAttribute("phoneNumber")
    public String phoneNumber(Model model) {
        return "";
    }
}
