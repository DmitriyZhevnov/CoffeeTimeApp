package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.repository.EmployeeRepository;
import ru.zhevnov.coffeeTime.service.IEmployeeService;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class EmployeeService implements IEmployeeService {

    private final EmployeeRepository employeeRepository;

    public EmployeeService(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

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

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        Employee employee = employeeRepository.findByLogin(s);
        if (employee == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return Employee.fromUser(employee);
    }
}
