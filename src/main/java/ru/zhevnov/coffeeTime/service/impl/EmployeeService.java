package ru.zhevnov.coffeeTime.service.impl;

import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.repository.EmployeeRepository;
import ru.zhevnov.coffeeTime.service.IEmployeeService;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class EmployeeService implements IEmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Override
    public void setPhoneNumberAndAddress(Employee employee, String phoneNumber, String address) {
//        employeeDao.setPhoneNumberAndAddress(employee, phoneNumber, address);
    }

    @Override
    public boolean checkLoginForExist(String login) {
//        return employeeDao.checkLoginForExist(login);
        return true;
    }

    @Override
    public void updateEmployee(Employee employee) {
//        employeeDao.updateEmployee(employee);
    }

    @Override
    public void registerNewEmployee(String name, String login, String password) {
//        employeeDao.registerNewEmployee(name, login, password);
    }

    @Transactional
    public List<Employee> returnAllEmployees() {
        return employeeRepository.findAll();
    }

    @Transactional
    public Employee checkAndReturnEmployeeByLoginAndPassword(String login, String password) {
        return employeeRepository.findByLoginAndPassword(login, password);
    }

    @Override
    public Employee returnEmployeeById(int employeeId) {
        return employeeRepository.getOne(employeeId);
    }
}
