package ru.zhevnov.coffeeTime.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.zhevnov.coffeeTime.entity.Shift;

import java.sql.Date;
import java.util.List;

@Repository
public interface ShiftRepository extends JpaRepository<Shift, Integer> {
    Shift findByEmployeeIdAndDateOpenedAndDateClosed(int employeeId, Date dateOpened, Date dateClosed);

    @Query("from Shift where employee.id = :idEmployee and dateOpened = :dateOpened and dateClosed is null")
    Shift returnOpenedShiftByEmployeeId(@Param("idEmployee") int idEmployee,@Param("dateOpened") Date date);

    List<Shift> findTop20ByOrderByDateOpenedDesc();

    @Query("from Shift  where employee.id = :idEmployee and dateOpened between :fromDate and :toDate")
    List<Shift> returnShiftsByEmployeeIdAndDate(@Param("idEmployee") int idEmployee,
                                                @Param("fromDate") Date fromDate,@Param("toDate") Date toDate);
}
