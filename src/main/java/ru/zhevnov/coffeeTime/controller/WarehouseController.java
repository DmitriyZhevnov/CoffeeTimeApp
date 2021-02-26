package ru.zhevnov.coffeeTime.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.service.ICommercialObjectQuantityOfItemsService;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IItemService;
import ru.zhevnov.coffeeTime.service.IShiftService;

@Controller
@SessionAttributes("user")
@RequestMapping("/warehouse")
public class WarehouseController {

    private final IItemService itemService;
    private final ICommercialObjectService commercialObjectService;
    private final ICommercialObjectQuantityOfItemsService commercialObjectQuantityOfItemsService;
    private final IShiftService shiftService;

    public WarehouseController(IItemService itemService, ICommercialObjectService commercialObjectService, ICommercialObjectQuantityOfItemsService commercialObjectQuantityOfItemsService, IShiftService shiftService) {
        this.itemService = itemService;
        this.commercialObjectService = commercialObjectService;
        this.commercialObjectQuantityOfItemsService = commercialObjectQuantityOfItemsService;
        this.shiftService = shiftService;
    }

    @GetMapping
    public String showWarehouse(Model model, Authentication authentication, @ModelAttribute("user") Employee employee) {
        if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
            model.addAttribute("commercialObjects", commercialObjectService.returnAllCommercialObjects());
            model.addAttribute("allItems", itemService.returnAllItems());
            return "main/warehouse/warehouse";
        } else if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_USER"))) {
            return "redirect:/warehouse/commercialObject?idCommercialObject=" +
                    shiftService.returnOpenedShiftByEmployeeId(employee.getId()).getCommercialObject().getId();
        } else return "redirect:/logout";
    }

    @PostMapping("/newItem")
    public String saveNewItem(@RequestParam("name") String itemName, @RequestParam("measure") String itemMeasure,
                              @RequestParam("quantityInWarehouse") String itemQuantityInWarehouse) {
        try {
            itemService.addNewItem(itemName, itemMeasure, Double.parseDouble(itemQuantityInWarehouse));
        } catch (NumberFormatException e) {
        }
        return "redirect:/warehouse";
    }

    @GetMapping("/{idItem}")
    public String editItemInWarehouse(Authentication authentication, @PathVariable("idItem") int idItem,
                                      @ModelAttribute("user") Employee employee, Model model) {
        if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
            model.addAttribute("item", itemService.returnItemById(idItem));
            return "main/warehouse/editItemInWarehouse";
        } else return "redirect:/main";
    }

    @PostMapping("/{idItem}")
    public String editItem(@PathVariable("idItem") int idItem,
                           @RequestParam("itemName") String nameItem, @RequestParam("itemMeasure") String measureItem,
                           @RequestParam("itemQuantity") String quantityItem, Model model) {
        try {
            itemService.updateItem(idItem, nameItem, measureItem, Double.parseDouble(quantityItem));
        } catch (NumberFormatException e) {
        }
        model.addAttribute("item", itemService.returnItemById(idItem));
        return "main/warehouse/editItemInWarehouse";
    }

    @GetMapping("/commercialObject")
    public String showWarehouseOfCommercialObject(@RequestParam("idCommercialObject") int idCommercialObject, Model model,
                                                  @ModelAttribute("user") Employee employee, Authentication authentication) {
        if (authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_USER"))) {
            int currentIdObject = shiftService.returnOpenedShiftByEmployeeId(employee.getId()).getCommercialObject().getId();
            model.addAttribute("commObject", commercialObjectService.returnCommercialObjectById(currentIdObject));
        } else {
            model.addAttribute("commercialObjects", commercialObjectService.returnAllCommercialObjects());
            model.addAttribute("commObject", commercialObjectService.returnCommercialObjectById(idCommercialObject));
            model.addAttribute("items", itemService.returnItemsForCommercialObject(idCommercialObject));
        }
        return "main/warehouse/commercialObjectsWarehouse";
    }

    @PostMapping("/commercialObject/{idItem}")
    public String editItemInCommercialObjectWithValues(@PathVariable("idItem") int idItem,
                                                       @RequestParam("itemQuantity") String quantityItem,
                                                       @RequestParam("idCommercialObject") int idCommercialObject) {
        try {
            commercialObjectQuantityOfItemsService.updateWithNewData(idItem, Double.parseDouble(quantityItem));
        } catch (NumberFormatException e) {
        }
        return "redirect:/warehouse/commercialObject?idCommercialObject=" + idCommercialObject;
    }

    @PostMapping("/commercialObject/{idCommercialObject}/addItem")
    public String addItemToCommercialObject(@PathVariable("idCommercialObject") int idCommercialObject,
                                            @RequestParam(value = "idItem", required = false) String idItem) {
        if (idItem != null) {
            commercialObjectQuantityOfItemsService.addItemInCommercialObjectWarehouse(idCommercialObject, Integer.parseInt(idItem));
        }
        return "redirect:/warehouse/commercialObject?idCommercialObject=" + idCommercialObject;
    }
}
