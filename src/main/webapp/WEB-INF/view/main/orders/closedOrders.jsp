<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 09.02.2021
  Time: 13:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <title>orders</title>
</head>
<body>
<form action="/closedOrders/date" method="post">
    <p>Выберите объект:</p>
    <p>
        <select name="idCommercialObject">
            <c:forEach items="${allCommercialObjects}" var="commercialObject">
                <option value="${commercialObject.id}">${commercialObject.address}</option>
            </c:forEach>
        </select>
    </p>
    <p>Выберите дату: </p>
    <p><input type="date" name="date" value="${date}"></p>
    <p><input type="submit" value="Просмотр"></p>
</form>
<table border="1">
    <tr>
        <th>Время</th>
        <th>Итоговая сумма</th>
        <th>Сотрудник</th>
        <th>Информация</th>
        <th></th>
    </tr>
    <c:forEach items="${orders}" var="order">
        <tr>
            <td>${order.time}</td>
            <td>${order.cardAmount + order.cashAmount}</td>
            <td>${order.shift.employee.name}</td>
            <td>${order.info}</td>
            <td>
                <form action="/closedOrders/${order.id}" method="get">
                    <p><input type="submit" value="Инфо"></p>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/main">Назад</a>
</body>
</html>
