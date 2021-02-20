package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.zhevnov.coffeeTime.entity.Employee;

import java.util.Optional;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    Employee findByLoginAndPassword(String login, String password);
    Employee findByLogin(String login);
}
