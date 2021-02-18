package ru.zhevnov.coffeeTime.entity;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "shift")
public class Shift {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne
    @JoinColumn(name = "commercial_object_id")
    private CommercialObject commercialObject;
    @ManyToOne
    @JoinColumn(name = "employee_id")
    private Employee employee;
    @Column(name = "date_opened")
    private Date dateOpened;
    @Column(name = "time_opened")
    private Time timeOpened;
    @Column(name = "date_closed")
    private Date dateClosed;
    @Column(name = "time_closed")
    private Time timeClosed;

    @OneToMany(mappedBy = "shift", fetch = FetchType.LAZY)
    private Set<Order> orders = new HashSet<>();

    public Shift() {
    }

    public Shift(CommercialObject commercialObject, Employee employee, Date dateOpened, Time timeOpened, Date dateClosed, Time timeClosed) {
        this.commercialObject = commercialObject;
        this.employee = employee;
        this.dateOpened = dateOpened;
        this.timeOpened = timeOpened;
        this.dateClosed = dateClosed;
        this.timeClosed = timeClosed;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public CommercialObject getCommercialObject() {
        return commercialObject;
    }

    public void setCommercialObject(CommercialObject commercialObject) {
        this.commercialObject = commercialObject;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Date getDateOpened() {
        return dateOpened;
    }

    public void setDateOpened(Date dateOpened) {
        this.dateOpened = dateOpened;
    }

    public Time getTimeOpened() {
        return timeOpened;
    }

    public void setTimeOpened(Time timeOpened) {
        this.timeOpened = timeOpened;
    }

    public Date getDateClosed() {
        return dateClosed;
    }

    public void setDateClosed(Date dateClosed) {
        this.dateClosed = dateClosed;
    }

    public Time getTimeClosed() {
        return timeClosed;
    }

    public void setTimeClosed(Time timeClosed) {
        this.timeClosed = timeClosed;
    }

    public Set<Order> getOrders() {
        return orders;
    }

    public void setOrders(Set<Order> orders) {
        this.orders = orders;
    }

    @Override
    public String toString() {
        return "Shift{" +
                "id=" + id +
                ", commercialObject=" + commercialObject +
                ", employee=" + employee +
                ", dateOpened=" + dateOpened +
                ", timeOpened=" + timeOpened +
                ", dateClosed=" + dateClosed +
                ", timeClosed=" + timeClosed +
                '}';
    }
}
