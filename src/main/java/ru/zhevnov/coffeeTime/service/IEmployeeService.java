package ru.zhevnov.coffeeTime.service;

import org.springframework.security.core.userdetails.UserDetailsService;
import ru.zhevnov.coffeeTime.entity.Employee;

import java.util.List;

public interface IEmployeeService extends UserDetailsService {
    void setPhoneNumberAndAddress(Employee employee, String phoneNumber, String address);
    boolean checkLoginForExist(String login);
    void updateEmployee(Employee employee);
    void registerNewEmployee(String name, String login, String password);
    List<Employee> returnAllEmployees();
    Employee checkAndReturnEmployeeByLoginAndPassword(String login, String password);
    Employee returnEmployeeById(int employeeId);
    Employee returnEmployeeByLogin(String login);

}
