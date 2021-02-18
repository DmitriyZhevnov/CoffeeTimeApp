package ru.zhevnov.coffeeTime.service.impl;

import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.CommercialObject;
import ru.zhevnov.coffeeTime.entity.Employee;
import ru.zhevnov.coffeeTime.entity.Shift;
import ru.zhevnov.coffeeTime.repository.CommercialObjectRepository;
import ru.zhevnov.coffeeTime.repository.EmployeeRepository;
import ru.zhevnov.coffeeTime.repository.ShiftRepository;
import ru.zhevnov.coffeeTime.service.ICommercialObjectService;
import ru.zhevnov.coffeeTime.service.IEmployeeService;
import ru.zhevnov.coffeeTime.service.IShiftService;

import javax.transaction.Transactional;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@Service
public class ShiftService implements IShiftService {

    @Autowired
    private ShiftRepository shiftRepository;
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private ICommercialObjectService commercialObjectService;


    @Transactional
    public void checkOrOpenTheShift(int idEmployee, int commercialObjectId) {
        Time time = new Time(System.currentTimeMillis());
        Date date = new Date(System.currentTimeMillis());
        Shift currentShift = shiftRepository.findByEmployeeIdAndDateOpenedAndDateClosed(idEmployee, date, null);
        if (currentShift == null) {
            Shift shift = new Shift();
            shift.setEmployee(employeeService.returnEmployeeById(idEmployee));
            shift.setDateOpened(date);
            shift.setTimeOpened(time);
            shift.setCommercialObject(commercialObjectService.returnCommercialObjectById(commercialObjectId));
            shiftRepository.save(shift);
        } else {
            if (currentShift.getCommercialObject().getId() != commercialObjectId) {
                currentShift.setDateClosed(new Date(System.currentTimeMillis()));
                currentShift.setTimeClosed(new Time(System.currentTimeMillis()));
                shiftRepository.save(currentShift);
                Shift newCurrentShift = new Shift();
                newCurrentShift.setEmployee(employeeService.returnEmployeeById(idEmployee));
                newCurrentShift.setDateOpened(date);
                newCurrentShift.setTimeOpened(time);
                newCurrentShift.setCommercialObject(commercialObjectService.returnCommercialObjectById(commercialObjectId));
                shiftRepository.save(newCurrentShift);
            }
        }
    }

    @Override
    public void closeShift(int idEmployee) {

    }

    @Transactional
    public Shift returnOpenedShiftByEmployeeId(int idEmployee) {
        return shiftRepository.returnOpenedShiftByEmployeeId(idEmployee, new Date(System.currentTimeMillis()));
    }

    @Transactional
    public List<Shift> returnAllShifts() {
        return shiftRepository.findTop20ByOrderByDateOpenedDesc();
    }

    @Transactional
    public List<Shift> returnShiftsByEmployeeIdAndDate(int idEmployee, Date fromDate, Date toDate) {
        return shiftRepository.returnShiftsByEmployeeIdAndDate(idEmployee, fromDate, toDate);
    }

    @Transactional
    public String returnTotalTimeOfShiftsByEmployeeIdAndDate(int idEmployee, Date fromDate, Date toDate) {
        List<Shift> shiftList = returnShiftsByEmployeeIdAndDate(idEmployee, fromDate, toDate);
        long totalTime = 0;
        for (Shift shift : shiftList) {
            if (shift.getTimeClosed() == null) {
                continue;
            }
            totalTime += Math.abs(shift.getTimeClosed().getTime() - shift.getTimeOpened().getTime());
        }
        double hours = Double.parseDouble(String.valueOf(totalTime)) / 3600000;
        return String.format("%.1f", hours);
    }

    @Transactional
    public Shift returnShiftById(int idShift) {
        return shiftRepository.getOne(idShift);
    }

    @Transactional
    public void updateShiftWithNewData(int idShift, int idCommercialObject, int idEmployee, Date dateOpened, Time timeOpened, Date dateClosed, Time timeClosed) {
        Shift shift = shiftRepository.getOne(idShift);
        shift.setEmployee(employeeService.returnEmployeeById(idEmployee));
        shift.setCommercialObject(commercialObjectService.returnCommercialObjectById(idCommercialObject));
        shift.setDateOpened(dateOpened);
        shift.setDateClosed(dateClosed);
        shift.setTimeOpened(timeOpened);
        shift.setTimeClosed(timeClosed);
        shiftRepository.save(shift);
    }
}
