package ru.zhevnov.coffeeTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.service.IEmployeeService;

@Controller
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private MessageSource messageSource;

    @GetMapping
    public String showAll(Model model) {
        model.addAttribute("allEmployees", employeeService.returnAllEmployeesWithRoleUser());
        model.addAttribute("dismissedEmployees", employeeService.returnAllDismissedEmployees());
        return "main/employees/employees";
    }

    @PostMapping
    public String newEmployee(@RequestParam("name") String name, @RequestParam("login") String login,
                              @RequestParam("password") String password, Model model) {
        if (!name.isEmpty() && !login.isEmpty() && !password.isEmpty()) {
            employeeService.addNewEmployee(name, login, password);
            return "redirect:/employees";
        } else {
            String errorMessage = messageSource.getMessage("employee.error", new Object[]{"employee.error"},
                    LocaleContextHolder.getLocale());
            model.addAttribute("msg", errorMessage);
            model.addAttribute("allEmployees", employeeService.returnAllEmployeesWithRoleUser());
            model.addAttribute("dismissedEmployees", employeeService.returnAllDismissedEmployees());
            return "main/employees/employees";
        }
    }

    @GetMapping("/{idEmployee}/updatePassword")
    public String updatePasswordForm(@PathVariable("idEmployee") int idEmployee, Model model){
        model.addAttribute("employee", employeeService.returnEmployeeById(idEmployee));
        return "/main/employees/updatePassword";
    }

    @PatchMapping("/{idEmployee}/updatePassword")
    public String updatePassword(@PathVariable("idEmployee") int idEmployee, @RequestParam("password") String password,
                                 Model model){
        employeeService.updatePassword(idEmployee, password);
        return "redirect:/employees";
    }

    @PatchMapping("/{idEmployee}/dismiss")
    public String dismissEmployee(@PathVariable("idEmployee") int idEmployee){
        employeeService.dismissEmployee(idEmployee);
        return "redirect:/employees";
    }

    @PatchMapping("/{idEmployee}/return")
    public String returnEmployee(@PathVariable("idEmployee") int idEmployee){
        employeeService.retractTermination(idEmployee);
        return "redirect:/employees";
    }
}
