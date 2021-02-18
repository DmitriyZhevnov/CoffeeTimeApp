package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.Composition;

@Repository
public interface CompositionRepository extends JpaRepository<Composition, Integer> {
}
