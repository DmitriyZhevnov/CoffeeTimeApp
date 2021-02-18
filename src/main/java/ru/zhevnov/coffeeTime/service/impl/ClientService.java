package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Client;
import ru.zhevnov.coffeeTime.repository.ClientRepository;
import ru.zhevnov.coffeeTime.service.IClientService;

import javax.transaction.Transactional;

@Service
public class ClientService implements IClientService {

    @Autowired
    private ClientRepository clientRepository;

    @Transactional
    public void registerNewClient(String name, String phoneNumber) {
        clientRepository.save(new Client(name, phoneNumber, 1));
    }

    @Override
    public Client returnClientByPhoneNumber(String phoneNumber) {
        return clientRepository.getByPhoneNumber(phoneNumber);
    }

    @Override
    public void addOnePercentToDiscount(int idClient) {
//        sessionFactory.getCurrentSession().clear();
        Client client = clientRepository.getOne(idClient);
        int discount = client.getDiscount();
        if (discount < 20){
            client.setDiscount(++discount);
        }
        clientRepository.save(client);
    }
}
