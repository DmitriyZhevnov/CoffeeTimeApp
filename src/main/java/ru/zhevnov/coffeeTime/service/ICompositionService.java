package ru.zhevnov.coffeeTime.service;

import ru.zhevnov.coffeeTime.entity.Composition;

public interface ICompositionService {
    Composition returnById(int id);
    void saveOrUpdate(Composition composition);
    void removeComposition(Composition composition);
}
