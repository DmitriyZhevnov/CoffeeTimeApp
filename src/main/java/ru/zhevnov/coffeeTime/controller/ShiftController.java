package ru.zhevnov.coffeeTime.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IEmployeeService;
import ru.zhevnov.coffeeTime.service.IShiftService;

import java.sql.Date;
import java.sql.Time;

@Controller
@SessionAttributes({"user"})
@RequestMapping("/shifts")
public class ShiftController {

    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private IShiftService shiftService;
    @Autowired
    private ICommercialObjectService commercialObjectService;

    @GetMapping()
    public String showAllShifts(@ModelAttribute("user") Employee employee, Model model) {
        model.addAttribute("allEmployees", employeeService.returnAllEmployees());
        model.addAttribute("shifts", shiftService.returnAllShifts());
        model.addAttribute("totalTime", null);
        return "main/shifts/allShifts";
    }

    @PostMapping("/date")
    public String showShiftsOfEmployee(@ModelAttribute("user") Employee employee, Model model,
                           @RequestParam("fromDate") Date fromDate, @RequestParam("toDate") Date toDate,
                           @RequestParam("idEmployee") int idEmployee) {
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        model.addAttribute("shifts", shiftService.returnShiftsByEmployeeIdAndDate(idEmployee, fromDate, toDate));
        model.addAttribute("allEmployees", employeeService.returnAllEmployees());
        model.addAttribute("allCommercialObjects", commercialObjectService.returnAllCommercialObjects());
        model.addAttribute("totalTime", "Всего часов: " + shiftService.returnTotalTimeOfShiftsByEmployeeIdAndDate(idEmployee, fromDate, toDate));
        return "main/shifts/allShifts";
    }

    @GetMapping("/{idShift}/update")
    public String showViewForUpdateShift(@PathVariable(name = "idShift") int idShift, Model model){
        model.addAttribute("shift", shiftService.returnShiftById(idShift));
        model.addAttribute("allEmployees", employeeService.returnAllEmployees());
        model.addAttribute("allCommercialObjects", commercialObjectService.returnAllCommercialObjects());
        return "main/shifts/editShift";
    }

    @PostMapping("/{idShift}/update")
    public String updateShift(@PathVariable(name = "idShift") int idShift, @RequestParam("idCommercialObject") int idCommercialObject,
                              @RequestParam(value = "idEmployee", required = false) int idEmployee, @RequestParam(value = "dateOpened", required = false) Date dateOpened,
                              @RequestParam(value = "timeOpened", required = false) Time timeOpened, @RequestParam(value = "dateClosed", required = false) Date dateClosed,
                              @RequestParam(value = "timeClosed", required = false) String timeClosedString, Model model){
        Time timeClosed;
        try{
            timeClosed =  Time.valueOf(timeClosedString);
        } catch(IllegalArgumentException e){
            timeClosedString = timeClosedString + ":00";
            timeClosed = Time.valueOf(timeClosedString);
        }
        shiftService.updateShiftWithNewData(idShift, idCommercialObject, idEmployee, dateOpened, timeOpened, dateClosed, timeClosed);
        model.addAttribute("shift", shiftService.returnShiftById(idShift));
        model.addAttribute("allEmployees", employeeService.returnAllEmployees());
        model.addAttribute("allCommercialObjects", commercialObjectService.returnAllCommercialObjects());
        return "redirect:/shifts";
    }

}
