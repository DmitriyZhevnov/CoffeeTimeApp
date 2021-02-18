package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.*;
import ru.zhevnov.coffeeTime.repository.CommercialObjectItemQuantityRepository;
import ru.zhevnov.coffeeTime.repository.CommercialObjectRepository;
import ru.zhevnov.coffeeTime.repository.EmployeeRepository;
import ru.zhevnov.coffeeTime.repository.ShiftRepository;
import ru.zhevnov.coffeeTime.service.ICommercialObjectQuantityOfItemsService;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IOrderService;
import ru.zhevnov.coffeeTime.service.IShiftService;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CommercialObjectService implements ICommercialObjectService {

    @Autowired
    private CommercialObjectRepository commercialObjectRepository;
    @Autowired
    private EmployeeRepository employeeRepository;
    @Autowired
    private IShiftService shiftService;
    @Autowired
    private ICommercialObjectQuantityOfItemsService commercialObjectQuantityOfItemsService;
    @Autowired
    private IOrderService orderService;

    @Transactional
    public List<CommercialObject> returnAllCommercialObjects() {
        return commercialObjectRepository.findAll();
    }

    @Transactional
    public CommercialObject returnCommercialObjectById(int commercialObjectId) {
        return commercialObjectRepository.getOne(commercialObjectId);
    }

    @Transactional
    public void submitItemsFromCommercialObjectsStorage(int idEmployee) {
        Employee employee = employeeRepository.getOne(idEmployee);
        Shift shift = shiftService.returnOpenedShiftByEmployeeId(employee.getId());
        CommercialObject cObject = shift.getCommercialObject();
        for (BasketItem basketItem : employee.getBasket().getBasketItems()) {
            int countOfItemsInBasket = basketItem.getQuantity();
            Product product = basketItem.getProducts().get(0);
            List<Composition> compositions = product.getComposition();
            for (Composition composition : compositions) {
                Item item = composition.getItem();
                double quantityItemInComposition = composition.getQuantity();
                CommercialObjectQuantityOfItems commercialObjectQuantityOfItems = item.getCommercialObjectQuantityOfItems().stream().filter(s -> s.getCommercialObject().getId() == cObject.getId()).collect(Collectors.toList()).get(0);
                double quantityItemInCommercialObject = commercialObjectQuantityOfItems.getQuantity();
                commercialObjectQuantityOfItems.setQuantity(quantityItemInCommercialObject - (quantityItemInComposition * countOfItemsInBasket));
                commercialObjectQuantityOfItemsService.saveOrUpdate(commercialObjectQuantityOfItems);
            }
        }
    }

    @Transactional
    public void addItemsFromOrderInCommercialObjectsStorage(int idOrder) {
        Order order = orderService.returnOrderById(idOrder);
        CommercialObject commercialObject =  order.getShift().getCommercialObject();
        for (OrderItem orderItem : order.getOrderItems()) {
            int countOfItemsInOrder = orderItem.getQuantity();
            Product product = orderItem.getProducts().get(0);
            List<Composition> compositions = product.getComposition();
            for (Composition composition : compositions) {
                Item item = composition.getItem();
                double quantityItemInComposition = composition.getQuantity();
                CommercialObjectQuantityOfItems commercialObjectQuantityOfItems = item.getCommercialObjectQuantityOfItems()
                        .stream().filter(s -> s.getCommercialObject().getId() == commercialObject.getId()).collect(Collectors.toList()).get(0);
                double quantityItemInCommercialObject = commercialObjectQuantityOfItems.getQuantity();
                commercialObjectQuantityOfItems.setQuantity(quantityItemInCommercialObject + (quantityItemInComposition * countOfItemsInOrder));
                commercialObjectQuantityOfItemsService.saveOrUpdate(commercialObjectQuantityOfItems);
            }
        }
    }

    @Override
    public void addItemInCommercialObjectWarehouse(int idCommercialObject, int idItem) {

    }

    @Transactional
    public void saveOrUpdate(CommercialObject commercialObject) {
        commercialObjectRepository.save(commercialObject);
    }
}
