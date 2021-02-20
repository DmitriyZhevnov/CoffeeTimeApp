package ru.zhevnov.coffeeTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.service.IShiftService;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/main")
@SessionAttributes({"user"})
public class MainController {
    @Autowired
    private IShiftService shiftService;

    @GetMapping
    public String showMainPage(@ModelAttribute("user") Employee employee, Model model) {
        model.addAttribute("shift", shiftService.returnOpenedShiftByEmployeeId(employee.getId()));
        return "main/mainPage";
    }

    @GetMapping("/closeShift")
    public String closeShift(@ModelAttribute("user") Employee employee, HttpSession httpsession, SessionStatus status) {
        shiftService.closeShift(employee.getId());
        return "redirect:/logout";
    }
}
