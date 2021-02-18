package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.zhevnov.coffeeTime.entity.Client;

public interface ClientRepository extends JpaRepository<Client, Integer> {
    Client getByPhoneNumber(String phoneNumber);
}
