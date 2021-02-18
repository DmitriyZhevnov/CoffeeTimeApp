package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.CommercialObjectQuantityOfItems;

import java.util.List;

public interface ICommercialObjectQuantityOfItemsService {
    void saveOrUpdate(CommercialObjectQuantityOfItems commercialObjectQuantityOfItems);
    List<CommercialObjectQuantityOfItems> returnAll();
    void updateWithNewData(int idItem, double quantityOfItem);
    void addItemInCommercialObjectWarehouse(int idCommercialObject, int idItem);
}
