package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.Client;

@Repository
public interface ClientRepository extends JpaRepository<Client, Integer> {
    Client getByPhoneNumber(String phoneNumber);
}
