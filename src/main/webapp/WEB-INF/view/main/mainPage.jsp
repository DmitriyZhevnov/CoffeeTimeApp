<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <title><spring:message code="main.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>

<header class='header'>
    <div class='header-data'>
        <div class='header-data_user'><spring:message code="main.tradingObj"/>: ${shift.commercialObject.address}</div>
        <div class='header-data_user'><spring:message code="main.shiftOpened"/>: ${shift.timeOpened}</div>
        <div class='header-data_user'><spring:message code="main.currentUser"/>: ${shift.employee.name}</div>
        <div>
            <a title="English" href="?lang=en">
                <img src="<c:url value="/images/uk.jpg"/>" width="30px" height="30px" class="round">
            </a>
            <a title="Russian" href="?lang=ru">
                <img src="<c:url value="/images/ru.png"/>" width="30px" height="30px" class="round">
            </a>
        </div>
    </div>
</header>
<br/>
<div class="user-section">
    <sec:authorize access="hasRole('ADMIN')">
        <div id="grid-admin">
            <div>
                <form action="/newOrder" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.makeOrder"/>
                    </button>
                </form>
            </div>
            <div>
                <form action="/shifts" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.workingTimeTracking"/>
                    </button>
                </form>
            </div>
            <div>
                <form action="/main/closeShift" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.closeShift"/>
                    </button>
                </form>
            </div>
            <div>
                <form action="/closedOrders" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.closedOrders"/>
                    </button>
                </form>
            </div>
            <div>
                <form action="/menu" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.menu"/>
                    </button>
                </form>
            </div>
            <div>
                <form action="/report" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.report"/>
                    </button>
                </form>
            </div>
            <div>
                <form action="/employees" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="employees"/>
                    </button>
                </form>
            </div>
            <div class='box7'>
                <form action="/warehouse" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.warehouse"/>
                    </button>
                </form>
            </div>
            <div class='box8'>
                <form action="/logout" method="GET">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.block"/>
                    </button>
                </form>
            </div>
        </div>
    </sec:authorize>
    <sec:authorize access="hasRole('USER')">
        <div id="grid-user">
            <div class='box'>
                <form action="/newOrder" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.makeOrder"/>
                    </button>
                </form>
            </div>
            <div></div>
            <div class='box'>
                <form action="/main/closeShift" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.closeShift"/>
                    </button>
                </form>
            </div>
            <div class='box'>
                <form action="/closedOrders" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.closedOrders"/>
                    </button>
                </form>
            </div>
            <div>
            </div>
            <div class='box'>
                <form action="/report" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.report"/>
                    </button>
                </form>
            </div>
            <div class='box'>
                <form action="/warehouse" method="get">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.warehouse"/>
                    </button>
                </form>
            </div>
            <div class='box box8'>
                <form action="/logout" method="GET">
                    <button class="grid-button" type="submit">
                        <spring:message code="main.block"/>
                    </button>
                </form>
            </div>
        </div>
    </sec:authorize>
</div>
</body>
</html>