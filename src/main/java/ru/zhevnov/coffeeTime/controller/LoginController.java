package ru.zhevnov.coffeeTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IEmployeeService;
import ru.zhevnov.coffeeTime.service.IShiftService;

import javax.servlet.http.HttpSession;
import java.security.Principal;

@Controller
@RequestMapping("/login")
@SessionAttributes("user")
public class LoginController {

    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private ICommercialObjectService commercialObjectService;
    @Autowired
    private IShiftService shiftService;

    @ModelAttribute("user")
    public Employee newEmployee() {
        return new Employee();
    }

    @ModelAttribute("comObj")
    public int commercialObject() {
        return 0;
    }


    @GetMapping
    public String showLoginPage(Model model) {
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

    @PostMapping("/openShift")
    public String openShift(Model model, @RequestParam(value = "comObj", required = false) String objectId, @ModelAttribute("user") Employee employee) {
        if (objectId == null) {
            model.addAttribute("commercialObjects", commercialObjectService.returnAllCommercialObjects());
            model.addAttribute("msg", "Выберите торговый объект");
            return "login/chooseCommercialObject";
        } else {
            shiftService.openShift(employee.getId(), Integer.parseInt(objectId));
            return "redirect:/main";

        }
    }
}










