package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Basket;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.entity.Role;
import ru.zhevnov.coffeeTime.repository.EmployeeRepository;
import ru.zhevnov.coffeeTime.service.IBasketService;
import ru.zhevnov.coffeeTime.service.IEmployeeService;
import ru.zhevnov.coffeeTime.service.IRoleService;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class EmployeeService implements IEmployeeService {

    @Autowired
    private PasswordEncoder bCryptPasswordEncoder;
    @Autowired
    private EmployeeRepository employeeRepository;
    @Autowired
    private IRoleService roleService;
    @Autowired
    private IBasketService basketService;

    @Transactional
    public List<Employee> returnAllEmployees() {
        return employeeRepository.findAll();
    }

    @Override
    public Employee returnEmployeeById(int employeeId) {
        return employeeRepository.getOne(employeeId);
    }

    @Transactional
    public Employee returnEmployeeByLogin(String login) {
        return employeeRepository.findByLogin(login);
    }

    @Transactional
    public void addNewEmployee(String name, String login, String password) {
        Role roleUser = roleService.returnUserValue();
        Basket basket = basketService.returnNewBasket();
        Employee employee = new Employee(name,login, bCryptPasswordEncoder.encode(password),roleUser);
        employee.setBasket(basket);
        employeeRepository.save(employee);
    }

    @Transactional
    public List<Employee> returnAllEmployeesWithRoleUser() {
        return employeeRepository.findAllByRole(roleService.returnUserValue());
    }

    @Override
    public List<Employee> returnAllDismissedEmployees() {
        return employeeRepository.findAllByRole(roleService.returnDismissedValue());
    }

    @Override
    public void updatePassword(int idEmployee, String password) {
        Employee employee = employeeRepository.getOne(idEmployee);
        employee.setPassword(bCryptPasswordEncoder.encode(password));
        employeeRepository.save(employee);
    }

    @Override
    public void dismissEmployee(int idEmployee) {
        Employee employee = employeeRepository.getOne(idEmployee);
        employee.setRole(roleService.returnDismissedValue());
        employeeRepository.save(employee);
    }

    @Override
    public void retractTermination(int idEmployee) {
        Employee employee = employeeRepository.getOne(idEmployee);
        employee.setRole(roleService.returnUserValue());
        employeeRepository.save(employee);
    }

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        Employee employee = employeeRepository.findByLogin(s);
        if (employee == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return Employee.fromUser(employee);
    }
}
