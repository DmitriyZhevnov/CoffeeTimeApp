<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 09.02.2021
  Time: 18:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<script src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
<script>
    $(document).ready(function () {
        PopUpCancelOrderHide();
        PopUpChangePaymentTypeHide();
        PopUpChangeToDifferentPaymentTypeHide();
    });

    function PopUpCancelOrderShow() {
        $("#popup4").show();
    }

    function PopUpCancelOrderHide() {
        $("#popup4").hide();
    }

    function PopUpChangePaymentTypeShow() {
        $("#popup5").show();
    }

    function PopUpChangePaymentTypeHide() {
        $("#popup5").hide();
    }

    function PopUpChangeToDifferentPaymentTypeShow() {
        $("#popup6").show();
    }

    function PopUpChangeToDifferentPaymentTypeHide() {
        $("#popup6").hide();
    }

    function subForSecond() {
        var secondTextArea = document.getElementById('second');
        document.getElementById('first').value = (${order.cardAmount + order.cashAmount} -secondTextArea.value).toFixed(2);
    }

    function subForFirst() {
        var firstTextArea = document.getElementById('first');
        document.getElementById('second').value = (${order.cardAmount + order.cashAmount} -firstTextArea.value).toFixed(2);
    }
</script>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/closedOrders">Назад</a>
            </div>
        </div>
    </header>
    <div class='editProduct-second-section'>
        <div class='error'>Ошибка: данные введены некорректно</div>
        <table border="1" style="border: 5px double #fa8f21">
            <tr style="background: bisque">
                <td>Время</td>
                <td colspan="2" align="center"> ${order.time}</td>
            </tr>
            <c:forEach items="${order.orderItems}" var="item">
                <tr>
                    <td>${item.products.get(0).name}</td>
                    <td align="center">${item.quantity} шт.</td>
                    <td align="center">${item.products.get(0).price}</td>
                </tr>
            </c:forEach>
            <tr style="background: bisque">
                <td>Предытог:</td>
                <td align="center" colspan="2">
                    <fmt:formatNumber type="number" maxFractionDigits="2"
                                      value="${100*(order.cashAmount+order.cardAmount)/(100-order.discount)}"/>
                </td>
            </tr>
            <tr style="background: bisque">
                <td>Скидка:</td>
                <td colspan="2" align="center">${order.discount}%</td>

            </tr>
            <tr style="background: bisque">
                <td>Итого к оплате:</td>
                <td colspan="2" align="center">${order.cardAmount + order.cashAmount}</td>
            </tr>
            <tr style="background: bisque">
                <td>Тип оплаты:</td>
                <td colspan="2" align="center">${order.paymentType}</td>
            </tr>
            <tr style="background: bisque">
                <td>Оплачено наличными:</td>
                <td colspan="2" align="center">${order.cashAmount}</td>
            </tr>
            <tr style="background: bisque">
                <td>Оплачено по карте:</td>
                <td colspan="2" align="center">${order.cardAmount}</td>
            </tr>
            <tr style="background: bisque">
                <td>Клиент:</td>
                <td align="center">${order.client.name}</td>
                <td align="center">${order.client.phoneNumber}</td>
            </tr>
            <tr>
                <td>
                    <div class="b-container_order" align="center">
                        <a style="font-size: 20px; color: black"  href="javascript:PopUpCancelOrderShow()">Отменить заказ</a>
                    </div>

                </td>
                <td colspan="2">
                    <div class="b-container_order" align="center">
                        <a style="font-size: 20px; color: black" href="javascript:PopUpChangePaymentTypeShow()">Изменить тип оплаты</a>
                    </div>

                </td>
            </tr>
        </table>
        <div class="b-popup" id="popup4">
            <form action="/closedOrders/${order.id}/cancel" method="post">
                <div class="b-popup-content">
                    <div><input name="typeOfOrderCancellation" type="radio" value="withWriteOffProducts"> Со списанием
                        продуктов
                    </div>
                    <div><input name="typeOfOrderCancellation" type="radio" value="withoutWriteOffProducts" checked> Без
                        списания продуктов
                    </div>
                    <div><textarea name="reason" style="width: 100%" cols="20" rows="3"></textarea></div>
                    <div><input type="submit" class="bottom-popup" value="Отменить заказ"></div>
                    <p align="center"><a class="href-popup" href="javascript:PopUpCancelOrderHide()">Назад</a></p>
                </div>
            </form>
        </div>
        <div class="b-popup" id="popup5">
            <div class="b-popup-content">
                <form action="/closedOrders/${order.id}/changePaymentType" method="post">
                    <p><input name="paymentType" type="radio" value="cash"> Наличные</p>
                    <p><input name="paymentType" type="radio" value="card"> Безналичные</p>
                    <div class="b-container">
                        <a class="href-popup" href="javascript:PopUpChangeToDifferentPaymentTypeShow()">Раздельный тип оплаты</a>
                    </div>
                    <p><textarea style="width: 100%" name="reason" cols="20" rows="3"></textarea></p>
                    <p><input type="submit" class="bottom-popup" value="Изменить"></p>
                </form>
                <p align="center"><a class="href-popup" href="javascript:PopUpChangePaymentTypeHide()">Назад</a></p>
            </div>
        </div>
        <div class="b-popup" id="popup6">
            <div class="b-popup-content">
                <form action="/closedOrders/${order.id}/changePaymentType" method="post">
                    <input type="hidden" name="paymentType" value="different">
                    <p align="right">Наличные: <textarea  id="first" name="cashAmount" oninput="subForFirst()" cols="15"
                                           rows="1">${order.cardAmount + order.cashAmount}</textarea></p>
                    <p align="right">Карта: <textarea id="second" oninput="subForSecond()" name="cardAmount" cols="15"
                                        rows="1"></textarea></p>
                    <p><textarea  style="width: 100%" name="reason" cols="20" rows="3"></textarea></p>
                    <p><input type="submit" class="bottom-popup" value=Изменить></p>
                </form>
                <p align="center"><a class="href-popup" href="javascript:PopUpChangeToDifferentPaymentTypeHide()">Назад</a></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
