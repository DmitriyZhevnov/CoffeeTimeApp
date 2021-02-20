package ru.zhevnov.coffeeTime.service.impl;

import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.repository.EmployeeRepository;
import ru.zhevnov.coffeeTime.repository.RoleRepository;
import ru.zhevnov.coffeeTime.service.IEmployeeService;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
//        User userFromDB = userRepository.findByUsername(user.getUsername());
//
//        if (userFromDB != null) {
//            return false;
//        }
//
//        user.setRoles(Collections.singleton(new Role(1L, "ROLE_USER")));
//        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
//        userRepository.save(user);
//        return true;
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
