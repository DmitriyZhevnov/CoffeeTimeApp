package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.CommercialObjectQuantityOfItems;

import java.util.List;

public interface ICommercialObjectQuantityOfItemsService {
    void saveOrUpdate(CommercialObjectQuantityOfItems commercialObjectQuantityOfItems);

    void updateWithNewData(int idItem, double quantityOfItem);

    void addItemInCommercialObjectWarehouse(int idCommercialObject, int idItem);
}
