package ru.zhevnov.coffeeTime.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "commercial_object")
public class CommercialObject {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String address;

    @OneToMany(mappedBy = "commercialObject", fetch = FetchType.LAZY)
    private Set<Shift> shifts = new HashSet<>();
    @OneToMany(mappedBy = "commercialObject", fetch = FetchType.EAGER)
    private List<CommercialObjectQuantityOfItems> commercialObjectQuantityOfItems = new ArrayList<>();

    public CommercialObject() {
    }

    public CommercialObject(String address) {
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Set<Shift> getShifts() {
        return shifts;
    }

    public void setShifts(Set<Shift> shifts) {
        this.shifts = shifts;
    }

    public List<CommercialObjectQuantityOfItems> getCommercialObjectQuantityOfItems() {
        return commercialObjectQuantityOfItems;
    }

    public void setCommercialObjectQuantityOfItems(List<CommercialObjectQuantityOfItems> commercialObjectQuantityOfItems) {
        this.commercialObjectQuantityOfItems = commercialObjectQuantityOfItems;
    }

    @Override
    public String toString() {
        return "CommercialObject{" +
                "id=" + id +
                ", address='" + address + '\'' +
                '}';
    }
}
