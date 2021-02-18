package ru.zhevnov.coffeeTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IEmployeeService;
import ru.zhevnov.coffeeTime.service.IShiftService;

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

    @GetMapping
    public String showLoginPage(Model model) {
        model.addAttribute("commercialObjects", commercialObjectService.returnAllCommercialObjects());
        return "login/loginPage";
    }

    @PostMapping
    public String login(@RequestParam("comObj") int objectId, @RequestParam("login") String login, @RequestParam("password") String pas, Model model) {
        Employee employee = employeeService.checkAndReturnEmployeeByLoginAndPassword(login, pas);
        if (employee == null) {
            return "страница не существующего";
        }
        shiftService.checkOrOpenTheShift(employee.getId(), objectId);
        model.addAttribute("user", employee);
        return "redirect:/main";
    }
}
