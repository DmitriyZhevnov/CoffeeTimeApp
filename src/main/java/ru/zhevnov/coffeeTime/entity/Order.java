package ru.zhevnov.coffeeTime.entity;
import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "date_order")
    private Date date;
    @Column(name = "time_order")
    private Time time;
    @Column(name = "cash_amount")
    private Double cashAmount;
    @Column(name = "card_amount")
    private Double cardAmount;
    private int discount;
    @ManyToOne
    @JoinColumn(name = "shift_id")
    private Shift shift;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "client_id")
    private Client client;
    @Column(name = "payment_type")
    private String paymentType;
    private String info;

    @OneToMany(mappedBy = "order", fetch = FetchType.EAGER)
    private List<OrderItem> orderItems = new ArrayList<>();

    public Order() {
    }

    public Order(Date date, Time time, Double cashAmount, Double cardAmount, int discount, Shift shift, Client client, String paymentType, String info) {
        this.date = date;
        this.time = time;
        this.cashAmount = cashAmount;
        this.cardAmount = cardAmount;
        this.discount = discount;
        this.shift = shift;
        this.client = client;
        this.paymentType = paymentType;
        this.info = info;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public Double getCashAmount() {
        return cashAmount;
    }

    public void setCashAmount(Double cashAmount) {
        this.cashAmount = cashAmount;
    }

    public Double getCardAmount() {
        return cardAmount;
    }

    public void setCardAmount(Double cardAmount) {
        this.cardAmount = cardAmount;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public Shift getShift() {
        return shift;
    }

    public void setShift(Shift shift) {
        this.shift = shift;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", date=" + date +
                ", time=" + time +
                ", cashAmount=" + cashAmount +
                ", cardAmount=" + cardAmount +
                ", discount=" + discount +
                ", shift=" + shift +
                ", client=" + client +
                ", paymentType='" + paymentType + '\'' +
                ", info='" + info + '\'' +
                '}';
    }
}
