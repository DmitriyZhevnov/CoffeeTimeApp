package ru.zhevnov.coffeeTime.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "basket_item")
public class BasketItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne
    @JoinColumn(name = "basket_id")
    private Basket basket;
    private int quantity;

    @ManyToMany(mappedBy = "basketItems", fetch = FetchType.EAGER)
    private List<Product> products;

    public BasketItem() {
    }

    public BasketItem(Basket basket, Integer quantity) {
        this.basket = basket;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Basket getBasket() {
        return basket;
    }

    public void setBasket(Basket basket) {
        this.basket = basket;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "BasketItem{" +
                "id=" + id +
                ", basket=" + basket +
                ", quantity=" + quantity +
                '}';
    }
}
