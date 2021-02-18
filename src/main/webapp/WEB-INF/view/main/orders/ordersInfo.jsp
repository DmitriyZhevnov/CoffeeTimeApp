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
<style>
    * {
        font-family: Areal;
    }

    .b-container {
        /*width: 300px;*/
        /*height: 300px;*/
        /*background-color: #ccc;*/
        /*margin: 0px auto;*/
        /*padding: 10px;*/
        /*font-size: 30px;*/
        color: #000000;
    }

    .b-popup {
        width: 100%;
        min-height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        overflow: hidden;
        position: fixed;
        top: 0px;
    }

    .b-popup .b-popup-content {
        margin: 40px auto 0px auto;
        width: 250px;
        height: 150px;
        padding: 10px;
        background-color: #c5c5c5;
        border-radius: 5px;
        box-shadow: 0px 0px 10px #000;
    }
</style>
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
    function subForSecond(){
        var secondTextArea = document.getElementById('second');
        document.getElementById('first').value = (${order.cardAmount + order.cashAmount} - secondTextArea.value).toFixed(2);
    }
    function subForFirst(){
        var firstTextArea = document.getElementById('first');
        document.getElementById('second').value = (${order.cardAmount + order.cashAmount} - firstTextArea.value).toFixed(2);
    }
</script>
<head>
    <title>Title</title>
</head>
<body>
<table border="1">
    <tr>
        <td colspan="3">Время: ${order.time}</td>
    </tr>
    <c:forEach items="${order.orderItems}" var="item">
        <tr>
            <td>${item.products.get(0).name}</td>
            <td>${item.quantity} шт.</td>
            <td>${item.products.get(0).price}</td>
        </tr>
    </c:forEach>
    <tr>
        <td>Предытог:</td>
        <td colspan="2">
            <fmt:formatNumber type="number" maxFractionDigits="2"
                              value="${100*(order.cashAmount+order.cardAmount)/(100-order.discount)}"/>
        </td>
    </tr>
    <tr>
        <td>Скидка:</td>
        <td colspan="2">${order.discount}%</td>

    </tr>
    <tr>
        <td>Итого к оплате:</td>
        <td colspan="2">${order.cardAmount + order.cashAmount}</td>
    </tr>
    <tr>
        <td>Тип оплаты:</td>
        <td colspan="2">${order.paymentType}</td>
    </tr>
    <tr>
        <td>Оплачено наличными:</td>
        <td colspan="2">${order.cashAmount}</td>
    </tr>
    <tr>
        <td>Оплачено по карте:</td>
        <td colspan="2">${order.cardAmount}</td>
    </tr>
    <tr>
        <td>Клиент:</td>
        <td>${order.client.name}</td>
        <td>${order.client.phoneNumber}</td>
    </tr>
    <tr>
        <td>
            <div class="b-container">
                <a href="javascript:PopUpCancelOrderShow()">Отменить заказ</a>
            </div>
            <div class="b-popup" id="popup4">
                <div class="b-popup-content">
                    <form action="/closedOrders/${order.id}/cancel" method="post">
                        <p><input name="typeOfOrderCancellation" type="radio" value="withWriteOffProducts"> Со списанием продуктов</p>
                        <p><input name="typeOfOrderCancellation" type="radio" value="withoutWriteOffProducts" checked> Без списания продуктов</p>
                        <p><textarea name="reason" cols="20" rows="3"></textarea></p>
                        <p><input type="submit" value="Отменить заказ"></p>
                    </form>
                    <a href="javascript:PopUpCancelOrderHide()">Назад</a>
                </div>
            </div>
        </td>
        <td colspan="2">
            <div class="b-container">
                <a href="javascript:PopUpChangePaymentTypeShow()">Изменить тип оплаты</a>
            </div>
            <div class="b-popup" id="popup5">
                <div class="b-popup-content">
                    <form action="/closedOrders/${order.id}/changePaymentType" method="post">
                        <p><input name="paymentType" type="radio" value="cash"> Наличные</p>
                        <p><input name="paymentType" type="radio" value="card"> Безналичные</p>
                        <div class="b-container">
                            <a href="javascript:PopUpChangeToDifferentPaymentTypeShow()">Раздельный тип оплаты</a>
                        </div>
                        <p><textarea name="reason" cols="20" rows="3"></textarea></p>
                        <p><input type="submit" value="Изменить"></p>
                    </form>
                    <a href="javascript:PopUpChangePaymentTypeHide()">Назад</a>
                </div>
            </div>
            <div class="b-popup" id="popup6">
                <div class="b-popup-content">
                    <form action="/closedOrders/${order.id}/changePaymentType" method="post">
                        <input type="hidden" name="paymentType" value="different">
                        <p>Наличные: <textarea id="first" name="cashAmount" oninput="subForFirst()" cols="15" rows="1">${order.cardAmount + order.cashAmount}</textarea></p>
                        <p>Карты: <textarea id="second" oninput="subForSecond()" name="cardAmount" cols="15" rows="1"></textarea></p>
                        <p><textarea name="reason" cols="20" rows="3"></textarea></p>
                        <p><input type="submit" value=Изменить></p>
                    </form>
                    <a href="javascript:PopUpChangeToDifferentPaymentTypeHide()">Назад</a>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="3"><a href="/closedOrders">Назад</a></td>
    </tr>
</table>

</body>
</html>
