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

    @Query("from Shift where employee.id = :idEmployee and dateOpened = :dateOpened and dateClosed is null")
    Shift returnOpenedShiftByEmployeeId(@Param("idEmployee") int idEmployee, @Param("dateOpened") Date date);

    List<Shift> findTop20ByOrderByDateOpenedDesc();

    @Query("from Shift  where employee.id = :idEmployee and dateOpened between :fromDate and :toDate")
    List<Shift> returnShiftsByEmployeeIdAndDate(@Param("idEmployee") int idEmployee,
                                                @Param("fromDate") Date fromDate, @Param("toDate") Date toDate);

    @Query(value = "select sum(card_amount + cash_amount) as total, sum(card_amount) as card, sum(cash_amount) as cash," +
            " (select count(shift_id) from orders where date_order between :fromDate and :toDate and shift_id in" +
            " (select id from shift where date_opened between :fromDate and :toDate and commercial_object_id = :idCommercialObject) and (cash_amount != '0' or card_amount !='0')) as countOrder," +
            " (select count(shift_id) from orders where date_order between :fromDate and :toDate and shift_id in (select id from shift where date_opened between :fromDate and :toDate and commercial_object_id = :idCommercialObject) and cash_amount = '0' and card_amount ='0') as countOrderCanceled" +
            " from orders where date_order between :fromDate and :toDate and shift_id in (select id from shift where date_opened between :fromDate and :toDate and commercial_object_id = :idCommercialObject)", nativeQuery = true)
    List makeReport(@Param("idCommercialObject") int idCommercialObject, @Param("fromDate") Date fromDate, @Param("toDate") Date toDate);

}
