package ru.zhevnov.coffeeTime.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.service.IShiftService;

@Controller
@RequestMapping("/main")
@SessionAttributes({"user"})
public class MainController {
    private final IShiftService shiftService;

    public MainController(IShiftService shiftService) {
        this.shiftService = shiftService;
    }

    @GetMapping
    public String showMainPage(@ModelAttribute("user") Employee employee, Model model) {
        model.addAttribute("shift", shiftService.returnOpenedShiftByEmployeeId(employee.getId()));
        return "main/mainPage";
    }

    @GetMapping("/closeShift")
    public String closeShift(@ModelAttribute("user") Employee employee) {
        shiftService.closeShift(employee.getId());
        return "redirect:/logout";
    }
}
