<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <title><spring:message code="newOrder.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/functions.js"></script>
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
                <div class='first-section_href'><a href="/main">
                    <spring:message code="newOrder.back"/>
                </a></div>
                <div class='first-section_href'>
                    <a href="javascript:PopUpNewUserShow()">
                        <spring:message code="newOrder.newClient"/>
                    </a>
                </div>
                <div class='first-section_href'>
                    <a href="javascript:PopUpPayShow()">
                        <spring:message code="newOrder.pay"/>
                    </a>
                </div>

                <div class="b-popup" id="popup1">
                    <div class="b-popup-content">
                        <form action="/newOrder/pay" method="post">
                            <input type="hidden" name="paymentType" value="cash">
                            <p><input class="bottom-popup" type="submit" value=<spring:message code="newOrder.cash"/>>
                            </p>
                        </form>
                        <form action="/newOrder/pay" method="post">
                            <input type="hidden" name="paymentType" value="card">
                            <p><input class="bottom-popup" type="submit" value=<spring:message code="newOrder.card"/>>
                            </p>
                        </form>
                        <p align="center"><a class="href-popup" href="javascript:PopUpDifferentTypeOfPaymentShow()">
                            <spring:message code="newOrder.different"/>
                        </a></p>
                        <p align="center"><a class="href-popup" href="javascript:PopUpPayHide()"><spring:message
                                code="newOrder.back"/></a></p>
                    </div>
                </div>
                <div class="b-popup" id="popup3">
                    <div class="b-popup-content">
                        <form action="/newOrder/pay" method="post">
                            <input type="hidden" name="paymentType" value="different">
                            <p align="right"><spring:message code="newOrder.cash"/>: <textarea id="first"
                                                                                               name="cashAmount"
                                                                                               oninput="subForFirst(${totalCost})"
                                                                                               cols="15"
                                                                                               rows="1">${totalCost}</textarea>
                            </p>
                            <p align="right"><spring:message code="newOrder.card"/>: <textarea id="second"
                                                                                               oninput="subForSecond(${totalCost})"
                                                                                               name="cardAmount"
                                                                                               cols="15"
                                                                                               rows="1"></textarea></p>
                            <p><input class="bottom-popup" type="submit" value=
                            <spring:message code="newOrder.pay"/>></p>
                        </form>
                        <p align="center"><a class="href-popup" href="javascript:PopUpDifferentTypeOfPaymentHide()">
                            <spring:message code="newOrder.back"/>
                        </a>
                        </p>
                    </div>
                </div>
                <div class='bomba-pay'>
                    <div class='first-section_total-cost'>
                        <spring:message code="newOrder.totalCost"/>:
                    </div>
                    <div class="first-section_total-cost">${totalCost}</div>
                </div>
                <form action='/newOrder/makeDiscount' method='post'>
                    <div class='first-section_discount'>
                        <div><input class='first-section_discount-input' type="text"
                                    placeholder="<spring:message code="newOrder.phoneNumber"/>"
                                    name="phoneNumber" value="${phoneNumber}"></div>
                        <div>
                            <button class='first-section_discount-button'>
                                <spring:message code="newOrder.makeDiscount"/>
                            </button>
                        </div>
                    </div>
                </form>
                <div class='error'>${msg}</div>
            </div>
        </div>
        <div class='second-section'>
            <c:forEach items="${coffees}" var="product">
                <form action='/newOrder/add/${product.id}' method='get'>
                    <div class='products'>
                        <button class='products-button'>${product.name}</button>
                        <div class='products-price'>${product.price}</div>
                    </div>
                </form>
            </c:forEach>
        </div>
        <div class='third-section'>
            <c:forEach items="${drinks}" var="product">
                <form action='/newOrder/add/${product.id}' method='get'>
                    <div class='products'>
                        <button class='products-button' type="submit">${product.name}</button>
                        <div class='products-price'>${product.price}</div>
                    </div>
                </form>
            </c:forEach>
        </div>
        <div class='fouth-section'>
            <div class='fouth-section_drinks'>
                <c:forEach items="${additions}" var="product">
                    <form action='/newOrder/add/${product.id}' method='get'>
                        <div class='products'>
                            <button class='products-button' type="submit">${product.name}</button>
                            <div class='products-price'>${product.price}</div>
                        </div>
                    </form>
                </c:forEach>
            </div>
            <div class='fouth-section_bars'>
                <c:forEach items="${bars}" var="product">
                    <form action='/newOrder/add/${product.id}' method='get'>
                        <div class='products'>
                            <button class='products-button' type="submit">${product.name}</button>
                            <div class='products-price'>${product.price}</div>
                        </div>
                    </form>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<div class="b-popup" id="popup2">
    <div class="b-popup-content">
        <form action="/newOrder/newClient" method="post">
            <p align="right"><spring:message code="newOrder.name"/>: <textarea name="name" cols="20"
                                                                               rows="1"></textarea></p>
            <p align="right"><spring:message code="newOrder.phone"/>: <textarea name="pNumber" cols="20"
                                                                                rows="1"></textarea></p>
            <p><input class="bottom-popup" type="submit" value=<spring:message code="newOrder.register"/>></p>
        </form>
        <p align="center"><a class="href-popup" href="javascript:PopUpNewUserHide()"><spring:message
                code="newOrder.back"/></a></p>
    </div>
</div>
</body>
</html>