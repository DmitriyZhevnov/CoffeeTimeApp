package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.Employee;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    Employee findByLoginAndPassword(String login, String password);

    Employee findByLogin(String login);
}
