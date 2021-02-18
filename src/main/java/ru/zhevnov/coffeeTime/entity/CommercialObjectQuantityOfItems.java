package ru.zhevnov.coffeeTime.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "commercial_object_item_quantity")
public class CommercialObjectQuantityOfItems {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne
    @JoinColumn(name = "commercial_object_id")
    private CommercialObject commercialObject;
    private double quantity;

    @ManyToMany(mappedBy = "commercialObjectQuantityOfItems" , fetch = FetchType.EAGER)
    private List<Item> items;

    public CommercialObjectQuantityOfItems() {
    }

    public CommercialObjectQuantityOfItems(CommercialObject commercialObject, double quantity) {
        this.commercialObject = commercialObject;
        this.quantity = quantity;
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

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public List<Item> getItems() {
        return items;
    }

    public void setItems(List<Item> items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "CommercialObjectQuantityOfItems{" +
                "id=" + id +
                ", commercialObject=" + commercialObject +
                ", quantity=" + quantity +
                '}';
    }
}
