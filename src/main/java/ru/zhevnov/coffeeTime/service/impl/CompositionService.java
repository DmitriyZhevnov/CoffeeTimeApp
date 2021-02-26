package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.Composition;
import ru.zhevnov.coffeeTime.repository.CompositionRepository;
import ru.zhevnov.coffeeTime.service.ICompositionService;

import javax.transaction.Transactional;

@Service
public class CompositionService implements ICompositionService {

    private final CompositionRepository compositionRepository;

    public CompositionService(CompositionRepository compositionRepository) {
        this.compositionRepository = compositionRepository;
    }

    @Transactional
    public Composition returnById(int id) {
        return compositionRepository.getOne(id);
    }

    @Override
    public void saveOrUpdate(Composition composition) {
        compositionRepository.saveAndFlush(composition);
    }

    @Override
    public void removeComposition(Composition composition) {
        compositionRepository.delete(composition);
    }
}
