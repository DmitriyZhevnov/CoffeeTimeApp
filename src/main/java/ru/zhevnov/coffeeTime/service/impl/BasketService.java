package ru.zhevnov.coffeeTime.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.zhevnov.coffeeTime.entity.*;
import ru.zhevnov.coffeeTime.repository.*;
import ru.zhevnov.coffeeTime.service.IBasketService;
import ru.zhevnov.coffeeTime.service.IClientService;
import ru.zhevnov.coffeeTime.service.IEmployeeService;
import ru.zhevnov.coffeeTime.service.IProductService;

import javax.transaction.Transactional;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BasketService implements IBasketService {

    @Autowired
    private IClientService clientService;
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private BasketRepository basketRepository;
    @Autowired
    private BasketItemRepository basketItemRepository;
    @Autowired
    private IProductService productService;

    @Transactional
    public void addProductToBasket(int personId, int productId) {
        Employee employee = employeeService.returnEmployeeById(personId);
        try {
            if (employee.getBasket().getBasketItems().stream().anyMatch(basketItem -> basketItem.getProducts().get(0).getId() == productId)) {
                BasketItem basketItem = employee.getBasket().getBasketItems().stream().filter(s -> s.getProducts().get(0).getId() == productId).collect(Collectors.toList()).get(0);
                int firstCountInBasketItem = basketItem.getQuantity();
                basketItem.setQuantity(firstCountInBasketItem + 1);
                basketItemRepository.save(basketItem);
            } else {
                Product product = productService.returnProductById(productId);
                BasketItem basketItem = new BasketItem(employee.getBasket(), 1);
                product.getBasketItems().add(basketItem);
                basketItemRepository.save(basketItem);
                productService.saveOrUpdateProduct(product);
            }
        } catch (NullPointerException e) {
            Product product = productService.returnProductById(productId);
            BasketItem basketItem = new BasketItem(employee.getBasket(), 1);
            product.getBasketItems().add(basketItem);
            basketItemRepository.save(basketItem);
            productService.saveOrUpdateProduct(product);
        }
    }

    @Transactional
    public List<BasketItem> returnListOfProductsInBasket(int idEmployee) {
        return basketRepository.returnListOfProductsInBasket(idEmployee);
    }

    @Transactional
    public void deleteItem(int idEmployee, int idProduct) {
        Employee employee = employeeService.returnEmployeeById(idEmployee);
        BasketItem basketItem = employee.getBasket().getBasketItems().stream().filter(s -> s.getProducts().get(0).getId() == idProduct).collect(Collectors.toList()).get(0);
        Product product = productService.returnProductById(idProduct);
        employee.getBasket().getBasketItems().remove(basketItem);
        product.getBasketItems().remove(basketItem);
        basketItemRepository.delete(basketItem);
    }

    @Transactional
    public String returnTotalCostOfTheOrder(int idEmployee, String phoneNumber) {
        Client client = clientService.returnClientByPhoneNumber(phoneNumber);
        Employee employee = employeeService.returnEmployeeById(idEmployee);
        try {
            double totalCost = employee.getBasket().getBasketItems().stream().mapToDouble(item -> item.getQuantity() * item.getProducts().get(0).getPrice()).sum();
            DecimalFormat format = new DecimalFormat("##.00");
            DecimalFormatSymbols dfs = format.getDecimalFormatSymbols();
            dfs.setDecimalSeparator('.');
            format.setDecimalFormatSymbols(dfs);

            if (client == null) {
                return format.format(totalCost);
            } else {
                return format.format(totalCost - (totalCost / 100 * client.getDiscount()));
            }
        } catch (NullPointerException e) {
            return "0";
        }
    }

    @Transactional
    public void cleanBasket(int idEmployee) {
        Employee employee = employeeService.returnEmployeeById(idEmployee);
        while (!employee.getBasket().getBasketItems().isEmpty()) {
            deleteItem(employee.getId(), employee.getBasket().getBasketItems().get(0).getProducts().get(0).getId());
        }
    }

    @Transactional
    public void submitProductInBasket(int employeeId, int productId) {
        Employee employee = employeeService.returnEmployeeById(employeeId);
        BasketItem basketItem = employee.getBasket().getBasketItems().stream().filter(s -> s.getProducts().get(0).getId() == productId).collect(Collectors.toList()).get(0);
        int firstCountInBasketItem = basketItem.getQuantity();
        if (firstCountInBasketItem == 1) {
            deleteItem(employeeId, productId);
        } else {
            basketItem.setQuantity(firstCountInBasketItem - 1);
            basketItemRepository.save(basketItem);
        }
    }

    @Transactional
    public Basket returnNewBasket() {
        Basket basket = new Basket();
        basketRepository.save(basket);
        return basket;
    }
}
