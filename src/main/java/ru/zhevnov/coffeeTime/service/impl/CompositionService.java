package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Composition;
import ru.zhevnov.coffeeTime.repository.CompositionRepository;
import ru.zhevnov.coffeeTime.service.ICompositionService;

import javax.transaction.Transactional;

@Service
public class CompositionService implements ICompositionService {

    @Autowired
    private CompositionRepository compositionRepository;

    @Transactional
    public Composition returnById(int id) {
        return compositionRepository.getOne(id);
    }

    @Override
    public void saveOrUpdate(Composition composition) {
        compositionRepository.save(composition);
    }

    @Override
    public void removeComposition(Composition composition) {
        compositionRepository.delete(composition);
    }
}
