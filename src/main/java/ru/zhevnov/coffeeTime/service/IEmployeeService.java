package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.Employee;

import java.util.List;

public interface IEmployeeService {
    void setPhoneNumberAndAddress(Employee employee, String phoneNumber, String address);
    boolean checkLoginForExist(String login);
    void updateEmployee(Employee employee);
    void registerNewEmployee(String name, String login, String password);
    List<Employee> returnAllEmployees();
    Employee checkAndReturnEmployeeByLoginAndPassword(String login, String password);
    Employee returnEmployeeById(int employeeId);

}
