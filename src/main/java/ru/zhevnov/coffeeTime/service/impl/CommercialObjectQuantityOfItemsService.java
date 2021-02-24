package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.CommercialObject;
import ru.zhevnov.coffeeTime.entity.CommercialObjectQuantityOfItems;
import ru.zhevnov.coffeeTime.entity.Item;
import ru.zhevnov.coffeeTime.repository.CommercialObjectItemQuantityRepository;
import ru.zhevnov.coffeeTime.service.ICommercialObjectQuantityOfItemsService;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IItemService;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class CommercialObjectQuantityOfItemsService implements ICommercialObjectQuantityOfItemsService {

    @Autowired
    private CommercialObjectItemQuantityRepository commercialObjectItemQuantityRepository;
    @Autowired
    private ICommercialObjectService commercialObjectService;
    @Autowired
    private IItemService itemService;

    @Transactional
    public void saveOrUpdate(CommercialObjectQuantityOfItems commercialObjectQuantityOfItems) {
        commercialObjectItemQuantityRepository.save(commercialObjectQuantityOfItems);
    }

    @Transactional
    public void updateWithNewData(int idItem, double quantityOfItem) {
        CommercialObjectQuantityOfItems item = commercialObjectItemQuantityRepository.getOne(idItem);
        item.setQuantity(quantityOfItem);
        commercialObjectItemQuantityRepository.save(item);
    }

    @Transactional
    public void addItemInCommercialObjectWarehouse(int idCommercialObject, int idItem) {
        CommercialObject commercialObject = commercialObjectService.returnCommercialObjectById(idCommercialObject);
        Item item = itemService.returnItemById(idItem);
        CommercialObjectQuantityOfItems objectQuantityOfItems = new CommercialObjectQuantityOfItems();
        item.getCommercialObjectQuantityOfItems().add(objectQuantityOfItems);
        objectQuantityOfItems.setCommercialObject(commercialObject);
        commercialObjectItemQuantityRepository.save(objectQuantityOfItems);
        commercialObjectService.saveOrUpdate(commercialObject);
    }
}
