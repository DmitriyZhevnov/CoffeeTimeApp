<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
        //Скрыть PopUp при загрузке страницы
        PopUpPayHide();
        PopUpNewUserHide();
        PopUpDifferentTypeOfPaymentHide();
    });

    //Функция отображения PopUp
    function PopUpNewUserShow() {
        $("#popup2").show();
    }

    function PopUpPayShow() {
        $("#popup1").show();
    }

    function PopUpDifferentTypeOfPaymentShow() {
        $("#popup3").show();
    }

    //Функция скрытия PopUp
    function PopUpNewUserHide() {
        $("#popup2").hide();
    }

    function PopUpPayHide() {
        $("#popup1").hide();
    }

    function PopUpDifferentTypeOfPaymentHide() {
        $("#popup3").hide();
    }
    function subForSecond(){
        var secondTextArea = document.getElementById('second');
        document.getElementById('first').value = (${totalCost} - secondTextArea.value).toFixed(2);
    }
    function subForFirst(){
        var firstTextArea = document.getElementById('first');
        document.getElementById('second').value = (${totalCost} - firstTextArea.value).toFixed(2);
    }
</script>
<head>
    <title>newOrder</title>
</head>
<body>
<table height="100%" width="100%" border="1">
    <tr>
        <td width="30%" valign="top">
            <table border="1" width="100%" heigth="100%">
                <c:forEach items="${basket}" var="item">
                    <tr>
                        <td width="55%">${item.products.get(0).name}</td>
                        <td width="10%">${item.quantity}</td>
                        <td width="25%"><a title="add" href="/newOrder/add/${item.products.get(0).id}"><img
                                src="<c:url value="/images/addProduct.png"/>" width="20px" height="20px"
                                class="icon"></a>
                            <a title="sub" href="/newOrder/sub/${item.products.get(0).id}"><img
                                    src="<c:url value="/images/subProduct.png"/>" width="20px" height="20px"
                                    class="icon"></a>
                            <a title="delete" href="/newOrder/delete/${item.products.get(0).id}"><img
                                    src="<c:url value="/images/delProduct.png"/>" width="20px" height="20px"
                                    class="icon"></a>
                        </td>
                        <td width="10%">${item.products.get(0).price}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="4">
                        <form action='/newOrder/makeDiscount' method='post'>
                            <input type="text" name="phoneNumber" value="${phoneNumber}">
                            <input type='submit' value="Применить скидку"/>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">Итого к оплате: ${totalCost}</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <%--                                                                                    Оплатить--%>
                        <div class="b-container">
                            <a href="javascript:PopUpPayShow()">Оплатить</a>
                        </div>
                        <div class="b-popup" id="popup1">
                            <div class="b-popup-content">
                                <form action="/newOrder/pay" method="post">
                                    <input type="hidden" name="paymentType" value="cash">
                                    <p><input type="submit" value=Наличные></p>
                                </form>
                                <form action="/newOrder/pay" method="post">
                                    <input type="hidden" name="paymentType" value="card">
                                    <p><input type="submit" value=Безналичные></p>
                                </form>
                                <a href="javascript:PopUpDifferentTypeOfPaymentShow()">Раздельный тип оплаты</a>
                                <br/>
                                <a href="javascript:PopUpPayHide()">Назад</a>
                            </div>
                        </div>
                        <div class="b-popup" id="popup3">
                            <div class="b-popup-content">
                                <form action="/newOrder/pay" method="post">
                                    <input type="hidden" name="paymentType" value="different">
                                    <p>Наличные: <textarea id="first" name="cashAmount" oninput="subForFirst()" cols="15" rows="1">${totalCost}</textarea></p>
                                    <p>Карты: <textarea id="second" oninput="subForSecond()" name="cardAmount" cols="15" rows="1"></textarea></p>
                                    <p><input type="submit" value=Оплатить></p>
                                </form>
                                <a href="javascript:PopUpDifferentTypeOfPaymentHide()">Назад</a>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <%--                                                            Новый пользователь--%>
                        <div class="b-container">
                            <a href="javascript:PopUpNewUserShow()">Новый клиент</a>
                        </div>
                        <div class="b-popup" id="popup2">
                            <div class="b-popup-content">
                                <form action="/newOrder/newClient" method="post">
                                    <p>Имя: <textarea name="name" cols="15" rows="1"></textarea></p>
                                    <p>Телефон: <textarea name="pNumber" cols="15" rows="1"></textarea></p>
                                    <p><input type="submit" value=Зарегистрировать></p>
                                </form>
                                <a href="javascript:PopUpNewUserHide()">Назад</a>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <a href="/main">Назад</a>
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top">
            <table width="100%" cellpadding="2" cellspacing="1" border="1">
                <c:forEach items="${coffees}" var="product">
                    <tr>
                        <td>
                            <form action='/newOrder/add/${product.id}' method='get'>
                                <input type='submit' value="${product.name}"/>
                            </form>
                        </td>
                        <td>${product.price}</td>
                    </tr>
                </c:forEach>
            </table>
        </td>
        <td valign="top">
            <table width="100%" cellpadding="2" cellspacing="1" border="1">
                <c:forEach items="${drinks}" var="product">
                    <tr>
                        <td>
                            <form action='/newOrder/add/${product.id}' method='get'>
                                <input type='submit' value="${product.name}"/>
                            </form>
                        </td>
                        <td>${product.price}</td>
                    </tr>
                </c:forEach>
            </table>
            <table width="100%" cellpadding="2" cellspacing="1" border="1">
                <c:forEach items="${additions}" var="product">
                    <tr>
                        <td>
                            <form action='/newOrder/add/${product.id}' method='get'>
                                <input type='submit' value="${product.name}"/>
                            </form>
                        </td>
                        <td>${product.price}</td>
                    </tr>
                </c:forEach>
            </table>
        </td>
        <td valign="top">
            <table width="100%" cellpadding="2" cellspacing="1" border="1">
                <c:forEach items="${bars}" var="product">
                    <tr>
                        <td>
                            <form action='/newOrder/add/${product.id}' method='get'>
                                <input type='submit' value="${product.name}"/>
                            </form>
                        </td>
                        <td>${product.price}</td>
                    </tr>
                </c:forEach>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
