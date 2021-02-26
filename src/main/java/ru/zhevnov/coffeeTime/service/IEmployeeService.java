package ru.zhevnov.coffeeTime.service;

import org.springframework.security.core.userdetails.UserDetailsService;
import ru.zhevnov.coffeeTime.entity.Employee;

import java.util.List;

public interface IEmployeeService extends UserDetailsService {

    List<Employee> returnAllEmployees();

    Employee returnEmployeeById(int employeeId);

    Employee returnEmployeeByLogin(String login);

    void addNewEmployee(String name, String login, String password);

    List<Employee> returnAllEmployeesWithRoleUser();

    List<Employee> returnAllDismissedEmployees();

    void updatePassword(int idEmployee, String password);

    void dismissEmployee(int idEmployee);

    void retractTermination (int idEmployee);

}
