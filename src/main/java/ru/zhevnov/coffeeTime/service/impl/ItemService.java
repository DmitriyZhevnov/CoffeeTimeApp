package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.CommercialObjectQuantityOfItems;
import ru.zhevnov.coffeeTime.entity.Item;
import ru.zhevnov.coffeeTime.repository.ItemRepository;
import ru.zhevnov.coffeeTime.service.IItemService;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class ItemService implements IItemService {

    @Autowired
    private ItemRepository itemRepository;

    @Transactional
    public List<Item> returnAllItems() {
        return itemRepository.findAll();
    }

    @Transactional
    public void addNewItem(String itemName, String itemMeasure, double itemQuantityInWarehouse) {
        itemRepository.save(new Item(itemName, itemMeasure, itemQuantityInWarehouse));
    }

    @Transactional
    public Item returnItemById(int idItem) {
        return itemRepository.getOne(idItem);
    }

    @Transactional
    public void updateItem(int idItem, String nameItem, String measureItem, double quantityOfItem) {
        Item item = itemRepository.getOne(idItem);
        item.setQuantityInWarehouse(quantityOfItem);
        item.setMeasure(measureItem);
        item.setName(nameItem);
        itemRepository.save(item);
    }

    @Override
    public CommercialObjectQuantityOfItems returnCommercialObjectItemById(int idItem) {
        return null;
    }

}
