package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Role;
import ru.zhevnov.coffeeTime.repository.RoleRepository;
import ru.zhevnov.coffeeTime.service.IRoleService;

@Service
public class RoleService implements IRoleService {

    @Autowired
    private RoleRepository roleRepository;

    @Override
    public Role returnUserValue() {
        return roleRepository.getOne(2);
    }

    @Override
    public Role returnDismissedValue() {
        return roleRepository.getOne(3);
    }
}
