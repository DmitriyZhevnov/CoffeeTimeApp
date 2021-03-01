<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <title><spring:message code="closedOrder.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/functions.js"></script>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/closedOrders"><spring:message code="closedOrders.back"/></a>
            </div>
        </div>
    </header>
    <div class='editProduct-second-section'>
        <div class='error'>${msg}</div>
        <table border="1" style="border: 5px double #fa8f21">
            <tr style="background: bisque">
                <td><spring:message code="closedOrders.time"/></td>
                <td colspan="2" align="center"> ${order.time}</td>
            </tr>
            <c:forEach items="${order.orderItems}" var="item">
                <tr>
                    <td>${item.products.get(0).name}</td>
                    <td align="center">${item.quantity} шт.</td>
                    <td align="center">${item.products.get(0).price * item.quantity}
                    </td>
                </tr>
            </c:forEach>
            <tr style="background: bisque">
                <td><spring:message code="closedOrders.preSummary"/>:</td>
                <td align="center" colspan="2">
                    <fmt:formatNumber type="number" maxFractionDigits="2"
                                      value="${100*(order.cashAmount+order.cardAmount)/(100-order.discount)}"/>
                </td>
            </tr>
            <tr style="background: bisque">
                <td><spring:message code="closedOrders.discount"/>:</td>
                <td colspan="2" align="center">${order.discount}%</td>

            </tr>
            <tr style="background: bisque">
                <td><spring:message code="closedOrders.totalCost"/>:</td>
                <td colspan="2" align="center">
                    <fmt:formatNumber type="number" maxFractionDigits="2"
                                      value=" ${order.cardAmount + order.cashAmount}"/>
                </td>
            </tr>
            <tr style="background: bisque">
                <td><spring:message code="closedOrders.paymentType"/>:</td>
                <td colspan="2" align="center">${order.paymentType}</td>
            </tr>
            <tr style="background: bisque">
                <td><spring:message code="closedOrders.cash"/>:</td>
                <td colspan="2" align="center">${order.cashAmount}</td>
            </tr>
            <tr style="background: bisque">
                <td><spring:message code="closedOrders.card"/>:</td>
                <td colspan="2" align="center">${order.cardAmount}</td>
            </tr>
            <tr style="background: bisque">
                <td><spring:message code="closedOrders.client"/>:</td>
                <td align="center">${order.client.name}</td>
                <td align="center">${order.client.phoneNumber}</td>
            </tr>
            <tr>
                <td>
                    <div class="b-container_order" align="center">
                        <a style="font-size: 20px; color: black"
                           href="javascript:PopUpCancelOrderShow()"><spring:message code="closedOrders.cancel"/></a>
                    </div>

                </td>
                <td colspan="2">
                    <div class="b-container_order" align="center">
                        <a style="font-size: 20px; color: black"
                           href="javascript:PopUpChangePaymentTypeShow()"><spring:message
                                code="closedOrders.changePayment"/></a>
                    </div>

                </td>
            </tr>
        </table>
        <div class="b-popup" id="popup4">
            <form action="/closedOrders/${order.id}/cancel" method="post">
                <input type="hidden" name="_method" value="patch">
                <div class="b-popup-content">
                    <div><input name="typeOfOrderCancellation" type="radio" value="withWriteOffProducts">
                        <spring:message code="closedOrder.withWriteOff"/>
                    </div>
                    <div><input name="typeOfOrderCancellation" type="radio" value="withoutWriteOffProducts" checked>
                        <spring:message code="closedOrder.withoutWriteOff"/>
                    </div>
                    <div><textarea name="reason" style="width: 100%" cols="20" rows="3"></textarea></div>
                    <div><input type="submit" class="bottom-popup" value="<spring:message code="closedOrders.cancel"/>">
                    </div>
                    <p align="center"><a class="href-popup" href="javascript:PopUpCancelOrderHide()"><spring:message
                            code="closedOrders.back"/></a></p>
                </div>
            </form>
        </div>
        <div class="b-popup" id="popup5">
            <div class="b-popup-content">
                <form action="/closedOrders/${order.id}/changePaymentType" method="post">
                    <input type="hidden" name="_method" value="patch">
                    <p><input name="paymentType" type="radio" value="cash"> <spring:message code="newOrder.cash"/></p>
                    <p><input name="paymentType" type="radio" value="card"> <spring:message code="newOrder.card"/></p>
                    <div class="b-container">
                        <a class="href-popup" href="javascript:PopUpChangeToDifferentPaymentTypeShow()"><spring:message
                                code="newOrder.different"/></a>
                    </div>
                    <p><textarea style="width: 100%" name="reason" cols="20" rows="3"></textarea></p>
                    <p><input type="submit" class="bottom-popup" value="<spring:message code="closedOrder.change"/>">
                    </p>
                </form>
                <p align="center"><a class="href-popup" href="javascript:PopUpChangePaymentTypeHide()"><spring:message
                        code="back"/></a></p>
            </div>
        </div>
        <div class="b-popup" id="popup6">
            <div class="b-popup-content">
                <form action="/closedOrders/${order.id}/changePaymentType" method="post">
                    <input type="hidden" name="_method" value="patch">
                    <input type="hidden" name="paymentType" value="different">
                    <p align="right"><spring:message code="newOrder.cash"/>: <textarea id="first" name="cashAmount"
                                                                                       oninput="subForFirst(${order.cardAmount + order.cashAmount})" cols="15"
                                                                                       rows="1"><fmt:formatNumber type="number" maxFractionDigits="2" value=" ${order.cardAmount + order.cashAmount}"/>
                    </textarea>
                    </p>
                    <p align="right"><spring:message code="newOrder.card"/>: <textarea id="second"
                                                                                       oninput="subForSecond(${order.cardAmount + order.cashAmount})"
                                                                                       name="cardAmount" cols="15"
                                                                                       rows="1"></textarea></p>
                    <p><textarea style="width: 100%" name="reason" cols="20" rows="3"></textarea></p>
                    <p><input type="submit" class="bottom-popup" value=<spring:message code="closedOrder.change"/>></p>
                </form>
                <p align="center"><a class="href-popup"
                                     href="javascript:PopUpChangeToDifferentPaymentTypeHide()"><spring:message
                        code="back"/></a></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
