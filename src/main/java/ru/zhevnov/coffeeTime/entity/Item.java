package ru.zhevnov.coffeeTime.entity;

import javax.persistence.*;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "item")
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private String measure;
    @Column(name = "quantity_in_warehouse")
    private double quantityInWarehouse;

    @OneToMany(mappedBy = "item", fetch = FetchType.LAZY)
    private Set<Composition> compositions = new HashSet<>();
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "commercial_object_item",
            joinColumns = @JoinColumn(name = "item_id"),
            inverseJoinColumns = @JoinColumn(name = "commercial_object_item_quantity_id"))
    private List<CommercialObjectQuantityOfItems> commercialObjectQuantityOfItems;

    public Item() {
    }

    public Item(String name, String measure, double quantityInWarehouse) {
        this.name = name;
        this.measure = measure;
        this.quantityInWarehouse = quantityInWarehouse;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMeasure() {
        return measure;
    }

    public void setMeasure(String measure) {
        this.measure = measure;
    }

    public double getQuantityInWarehouse() {
        return quantityInWarehouse;
    }

    public void setQuantityInWarehouse(double quantityInWarehouse) {
        this.quantityInWarehouse = quantityInWarehouse;
    }

    public Set<Composition> getCompositions() {
        return compositions;
    }

    public void setCompositions(Set<Composition> compositions) {
        this.compositions = compositions;
    }

    public List<CommercialObjectQuantityOfItems> getCommercialObjectQuantityOfItems() {
        return commercialObjectQuantityOfItems;
    }

    public void setCommercialObjectQuantityOfItems(List<CommercialObjectQuantityOfItems> commercialObjectQuantityOfItems) {
        this.commercialObjectQuantityOfItems = commercialObjectQuantityOfItems;
    }

    @Override
    public String toString() {
        return "Item{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", measure='" + measure + '\'' +
                ", quantityInWarehouse=" + quantityInWarehouse +
                '}';
    }
}
