package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.Role;

public interface IRoleService {
    Role returnUserValue();
    void addNewRole(String name);
}
