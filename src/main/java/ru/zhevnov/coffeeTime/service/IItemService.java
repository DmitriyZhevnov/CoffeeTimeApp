package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.CommercialObjectQuantityOfItems;
import ru.zhevnov.coffeeTime.entity.Item;

import java.util.List;

public interface IItemService {
    List<Item> returnAllItems();

    List<Item> returnItemsForCommercialObject(int idCommercialObject);

    void addNewItem(String itemName, String itemMeasure, double itemQuantityInWarehouse);

    Item returnItemById(int idItem);

    void updateItem(int idItem, String nameItem, String measureItem, double quantityOfItem);

    CommercialObjectQuantityOfItems returnCommercialObjectItemById(int idItem);
}
