package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.CommercialObject;

@Repository
public interface CommercialObjectRepository extends JpaRepository<CommercialObject, Integer> {
}
