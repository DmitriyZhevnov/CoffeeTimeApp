<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
    <title><spring:message code="closedOrders.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/main">
                    <spring:message code="closedOrders.back"/>
                </a>
            </div>
        </div>
    </header>
    <div class='editProduct-second-section'>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <sec:authorize access="hasRole('ADMIN')">
                <div class='addNew addNew-column'>
                    <form action="/closedOrders/date" method="post">
                        <div>
                            <select class='addNew-ID' name="idCommercialObject">
                                <c:forEach items="${allCommercialObjects}" var="commercialObject">
                                    <option value="${commercialObject.id}">${commercialObject.address}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div><input type="date" class='addNew-ID' name="date" value="${date}"></div>
                        <div>
                            <button type="submit" style="color:#fa8f21" class='addNew-ID'>
                                <spring:message code="closedOrders.view"/>
                            </button>
                        </div>
                    </form>
                </div>
            </sec:authorize>
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>
                        <spring:message code="closedOrders.time"/>
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>
                        <spring:message code="closedOrders.totalCost"/>
                    </div>
                </div>
                <sec:authorize access="hasRole('USER')">
                    <div class='menuPage-section'>
                        <div class='menuPage-section-block'>
                            <spring:message code="closedOrders.paymentType"/>
                        </div>
                    </div>
                </sec:authorize>
                <sec:authorize access="hasRole('ADMIN')">
                    <div class='menuPage-section'>
                        <div class='menuPage-section-block'>
                            <spring:message code="closedOrders.employee"/>
                        </div>
                    </div>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-block'>
                            <spring:message code="closedOrders.info"/>
                        </div>
                    </div>
                </sec:authorize>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
        </div>
        <c:forEach items="${orders}" var="order">
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${order.time}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <fmt:formatNumber type="number" maxFractionDigits="2" value="${order.cardAmount + order.cashAmount}"/>
                    </div>
                </div>
                <sec:authorize access="hasRole('USER')">
                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>${order.paymentType}</div>
                    </div>
                </sec:authorize>
                <sec:authorize access="hasRole('ADMIN')">
                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>${order.shift.employee.name}</div>
                    </div>
                    <div class='menuPage-section'>
                        <div class='edit'>${order.info}</div>
                    </div>
                </sec:authorize>
                <div class='menuPage-section'>
                    <div class='edit'>
                        <form action="/closedOrders/${order.id}" method="get">
                            <button
                                    type="submit"
                                    class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                <spring:message code="closedOrders.detail"/>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
