package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.CommercialObject;

import java.util.List;

public interface ICommercialObjectService {
    List<CommercialObject> returnAllCommercialObjects();
    CommercialObject returnCommercialObjectById(int commercialObjectId);
    void submitItemsFromCommercialObjectsStorage(int idEmployee);
    void addItemsFromOrderInCommercialObjectsStorage(int idOrder);
    void addItemInCommercialObjectWarehouse(int idCommercialObject, int idItem);
    void saveOrUpdate(CommercialObject commercialObject);
}
