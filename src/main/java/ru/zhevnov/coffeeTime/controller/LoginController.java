package ru.zhevnov.coffeeTime.controller;

import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IEmployeeService;
import ru.zhevnov.coffeeTime.service.IShiftService;

import java.security.Principal;

@Controller
@RequestMapping("/login")
@SessionAttributes("user")
public class LoginController {

    private final IEmployeeService employeeService;
    private final ICommercialObjectService commercialObjectService;
    private final IShiftService shiftService;
    private final MessageSource messageSource;

    public LoginController(IEmployeeService employeeService, ICommercialObjectService commercialObjectService, IShiftService shiftService, MessageSource messageSource) {
        this.employeeService = employeeService;
        this.commercialObjectService = commercialObjectService;
        this.shiftService = shiftService;
        this.messageSource = messageSource;
    }


    @ModelAttribute("user")
    public Employee newEmployee() {
        return new Employee();
    }

    @ModelAttribute("comObj")
    public int commercialObject() {
        return 0;
    }


    @GetMapping
    public String showLoginPage() {
        return "login/loginPage";
    }

    @GetMapping("/failedEnter")
    public String failedEnter(Model model) {
        model.addAttribute("msg", "Неверное имя пользователя или пароль");
        return "login/loginPage";
    }

    @GetMapping("/successEnter")
    public String successEnter(Model model, Principal principal) {
        String login = principal.getName();
        Employee employee = employeeService.returnEmployeeByLogin(login);
        model.addAttribute("user", employee);
        if (shiftService.returnOpenedShiftByEmployeeId(employee.getId()) == null) {
            model.addAttribute("commercialObjects", commercialObjectService.returnAllCommercialObjects());
            return "login/chooseCommercialObject";
        } else {
            return "redirect:/main";
        }
    }

    @GetMapping("/openShift")
    public String openShift(Model model, @ModelAttribute("user") Employee employee) {
        String errorMessage = messageSource.getMessage("chooseComObj.choose", new Object[]{"chooseComObj.choose"},
                LocaleContextHolder.getLocale());
        model.addAttribute("commercialObjects", commercialObjectService.returnAllCommercialObjects());
        model.addAttribute("msg", errorMessage);
        return "login/chooseCommercialObject";
    }

    @PostMapping("/openShift")
    public String openShiftPost(Model model, @RequestParam(value = "comObj", required = false) String objectId,
                                @ModelAttribute("user") Employee employee) {
        String errorMessage = messageSource.getMessage("chooseComObj.choose", new Object[]{"chooseComObj.choose"},
                LocaleContextHolder.getLocale());
        if (objectId == null) {
            model.addAttribute("commercialObjects", commercialObjectService.returnAllCommercialObjects());
            model.addAttribute("msg", errorMessage);
            return "login/chooseCommercialObject";
        } else {
            shiftService.openShift(employee.getId(), Integer.parseInt(objectId));
            return "redirect:/main";
        }
    }
}










