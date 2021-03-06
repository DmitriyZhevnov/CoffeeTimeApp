package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.Client;

public interface IClientService {
    boolean registerNewClient(String name, String phoneNumber);

    Client returnClientByPhoneNumber(String phoneNumber);

    void addOnePercentToDiscount(int idClient);
}
