package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.zhevnov.coffeeTime.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Integer> {
}
