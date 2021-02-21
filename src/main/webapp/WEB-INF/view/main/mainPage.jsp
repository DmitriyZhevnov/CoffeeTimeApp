<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<header class='header'>
    <div class='header-data'>
        <div class='header-data_user'>Торговый объект: ${shift.commercialObject.address}</div>
        <div class='header-data_user'>Текущий пользователь: ${shift.employee.name} </div>
        <div class='header-data_user'>Смена открыта: ${shift.timeOpened}</div>
    </div>
</header>
<div class="user-section">
    <sec:authorize access="hasRole('ADMIN')">
        <div id="grid-admin">
            <div>
                <form action="/newOrder" method="get">
                    <button class="grid-button" type="submit">Принять заказ</button>
                </form>
            </div>
            <div>
                <form action="/shifts" method="get">
                    <button class="grid-button" type="submit">Учет рабочего времени</button>
                </form>
            </div>
            <div>
                <form action="/main/closeShift" method="get">
                    <button class="grid-button" type="submit">Закрыть смену</button>
                </form>
            </div>
            <div>
                <form action="/closedOrders" method="get">
                    <button class="grid-button" type="submit">Закрытые заказы</button>
                </form>
            </div>
            <div>
                <form action="/menu" method="get">
                    <button class="grid-button" type="submit">Меню</button>
                </form>
            </div>
            <div>
                <form action="/report" method="get">
                    <button class="grid-button" type="submit">Отчет</button>
                </form>
            </div>
            <div class='box7'>
                <form action="/warehouse" method="get">
                    <button class="grid-button" type="submit">Склад</button>
                </form>
            </div>
            <div class='box8'>
                <form action="/logout" method="GET">
                    <button class="grid-button" type="submit">Заблокировать</button>
                </form>
            </div>
        </div>
    </sec:authorize>
    <sec:authorize access="hasRole('USER')">
        <div id="grid-user">
            <div class='box'>
                <form action="/newOrder" method="get">
                    <button class="grid-button" type="submit">Принять заказ</button>
                </form>
            </div>
            <div>
            </div>
            <div class='box'>
                <form action="/main/closeShift" method="get">
                    <button class="grid-button" type="submit">Закрыть смену</button>
                </form>
            </div>
            <div class='box'>
                <form action="/closedOrders" method="get">
                    <button class="grid-button" type="submit">Закрытые заказы</button>
                </form>
            </div>
            <div>
            </div>
            <div class='box'>
                <form action="/report" method="get">
                    <button class="grid-button" type="submit">Отчет</button>
                </form>
            </div>
            <div class='box box8'>
                <form action="/logout" method="GET">
                    <button class="grid-button" type="submit">Заблокировать</button>
                </form>
            </div>
        </div>
    </sec:authorize>
</div>
</body>
</html>