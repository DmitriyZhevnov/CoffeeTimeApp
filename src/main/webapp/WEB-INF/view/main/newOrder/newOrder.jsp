<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
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

    function PopUpNewUserHide() {
        $("#popup2").hide();
    }

    function PopUpPayHide() {
        $("#popup1").hide();
    }

    function PopUpDifferentTypeOfPaymentHide() {
        $("#popup3").hide();
    }

    function subForSecond() {
        var secondTextArea = document.getElementById('second');
        document.getElementById('first').value = (${totalCost} -secondTextArea.value).toFixed(2);
    }

    function subForFirst() {
        var firstTextArea = document.getElementById('first');
        document.getElementById('second').value = (${totalCost} -firstTextArea.value).toFixed(2);
    }
</script>

<head>
    <title>Document</title>
    <%--    <script type="text/javascript" src="/js/functions.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/functions.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class="main">
    <div class='newOrder'>
        <div class='first-section'>
            <c:forEach items="${basket}" var="item">
                <div class='first-section_basket'>
                    <div class='first-section_basket-products'>
                        <div class='first-section_basket-products_product'>${item.products.get(0).name}</div>
                        <div class='first-section_basket-products_count'>${item.quantity}</div>
                        <div class='first-section_basket-products_calc'>
                            <a title="add" href="/newOrder/add/${item.products.get(0).id}"><img height="20px"
                                                                                                width="20px"
                                                                                                src="<c:url value="/images/addProduct.png"/>"></a>
                            <a title="sub" href="/newOrder/sub/${item.products.get(0).id}"><img height="20px"
                                                                                                width="20px"
                                                                                                src="<c:url value="/images/subProduct.png"/>"></a>
                            <a title="delete" href="/newOrder/delete/${item.products.get(0).id}"><img height="20px"
                                                                                                      width="20px"
                                                                                                      src="<c:url value="/images/delProduct.png"/>"></a>
                        </div>
                        <div class='first-section_basket-products_price'>${item.products.get(0).price}</div>
                    </div>
                </div>
            </c:forEach>
            <div class='bomba'>
                <div class='first-section_href'><a href="/main">Назад</a></div>
                <div class='first-section_href'><a href="javascript:PopUpNewUserShow()">Новый клиент</a></div>
                <div class='first-section_href'><a href="javascript:PopUpPayShow()">Оплатить</a></div>

                <div class="b-popup" id="popup1">
                    <div class="b-popup-content">
                        <form action="/newOrder/pay" method="post">
                            <input type="hidden" name="paymentType" value="cash">
                            <p><input class="bottom-popup" type="submit" value=Наличные></p>
                        </form>
                        <form action="/newOrder/pay" method="post">
                            <input type="hidden" name="paymentType" value="card">
                            <p><input class="bottom-popup" type="submit" value=Безналичные></p>
                        </form>
                        <p align="center"><a class="href-popup" href="javascript:PopUpDifferentTypeOfPaymentShow()">Раздельный тип
                            оплаты</a></p>
                        <p align="center"><a class="href-popup" href="javascript:PopUpPayHide()">Назад</a></p>
                    </div>
                </div>
                <div class="b-popup" id="popup3">
                    <div class="b-popup-content">
                        <form action="/newOrder/pay" method="post">
                            <input type="hidden" name="paymentType" value="different">
                            <p align="right">Наличные: <textarea id="first" name="cashAmount" oninput="subForFirst()"
                                                                 cols="15" rows="1">${totalCost}</textarea></p>
                            <p align="right">Карты: <textarea id="second" oninput="subForSecond()" name="cardAmount"
                                                              cols="15"
                                                              rows="1"></textarea></p>
                            <p><input class="bottom-popup" type="submit" value=Оплатить></p>
                        </form>
                        <p align="center"><a class="href-popup" href="javascript:PopUpDifferentTypeOfPaymentHide()">Назад</a></p>
                    </div>
                </div>


                <div class='bomba-pay'>
                    <div class='first-section_total-cost'>Итого к оплате:</div>
                    <div class="first-section_total-cost">${totalCost}</div>
                </div>
                <form action='/newOrder/makeDiscount' method='post'>
                    <div class='first-section_discount'>
                        <div><input class='first-section_discount-input' type="text" placeholder="Номер телефона"
                                    name="phoneNumber" value="${phoneNumber}"></div>
                        <div>
                            <button class='first-section_discount-button'>Применить скидку</button>
                        </div>
                    </div>
                </form>
                <div class='error'>Ошибка: данные введены некорректно</div>
            </div>
        </div>
        <div class='second-section'>
            <c:forEach items="${coffees}" var="product">
                <div class='products'>
                    <form action='/newOrder/add/${product.id}' method='get'>
                        <button class='products-button'>${product.name}</button>
                    </form>
                    <div class='products-price'>${product.price}</div>
                </div>
            </c:forEach>
        </div>
        <div class='third-section'>
            <c:forEach items="${additions}" var="product">
                <div class='products'>
                    <form action='/newOrder/add/${product.id}' method='get'>
                        <button class='products-button' type="submit">${product.name}</button>
                    </form>
                    <div class='products-price'>${product.price}</div>
                </div>
            </c:forEach>
        </div>
        <div class='fouth-section'>
            <div class='fouth-section_drinks'>
                <c:forEach items="${drinks}" var="product">

                    <div class='products'>
                        <form action='/newOrder/add/${product.id}' method='get'>
                            <button class='products-button' type="submit">${product.name}</button>
                        </form>
                        <div class='products-price'>${product.price}</div>
                    </div>
                </c:forEach>
            </div>
            <div class='fouth-section_bars'>
                <c:forEach items="${bars}" var="product">
                    <div class='products'>
                        <form action='/newOrder/add/${product.id}' method='get'>
                            <button class='products-button' type="submit">${product.name}</button>
                        </form>
                        <div class='products-price'>${product.price}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<div class="b-popup" id="popup2">
    <div class="b-popup-content">
        <form action="/newOrder/newClient" method="post">
            <p align="right">Имя: <textarea name="name" cols="20" rows="1"></textarea></p>
            <p align="right">Телефон: <textarea name="pNumber" cols="20" rows="1"></textarea></p>
            <p><input class="bottom-popup" type="submit" value=Зарегистрировать></p>
        </form>
        <p align="center"><a class="href-popup" href="javascript:PopUpNewUserHide()">Назад</a></p>
    </div>
</div>
</body>
</html>