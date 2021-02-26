package ru.zhevnov.coffeeTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.service.IEmployeeService;

@Controller
@RequestMapping("/employees")
public class EmployeeController {

    @Autowired
    private IEmployeeService employeeService;

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
            model.addAttribute("msg", "Введите все данные. Пользователь не был добавлен");
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
