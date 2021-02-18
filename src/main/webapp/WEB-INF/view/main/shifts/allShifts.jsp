<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 14.02.2021
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<script>
    function copyDate() {
        var fromDate = document.getElementById('first');
        document.getElementById('second').value = fromDate.value;
    }
</script>
<head>
    <title>Shifts</title>
</head>
<body>
<form action="/shifts/date" method="post">
    <p>Выберите сотрудника:</p>
    <p>
        <select name="idEmployee">
            <c:forEach items="${allEmployees}" var="employee">
                <option value="${employee.id}">${employee.name}</option>
            </c:forEach>
        </select>
    </p>
    <p>Выберите дату: </p>
    <p> С : <input type="date" id="first" name="fromDate" onchange="copyDate()" value="${fromDate}"></p>
    <p> По : <input type="date" id="second" name="toDate" value="${toDate}"></p>
    <p><input type="submit" value="Показать"></p>
</form>
<h2> ${totalTime} </h2>
<table border="1">
    <tr>
        <th>Торговый объект</th>
        <th>Дата открытия</th>
        <th>Время открытия</th>
        <th>Дата закрытия</th>
        <th>Время закрытия</th>
        <th>Сотрудник</th>
        <th></th>
    </tr>
    <c:forEach items="${shifts}" var="shift">
        <tr>
            <td>${shift.commercialObject.address}</td>
            <td>${shift.dateOpened}</td>
            <td>${shift.timeOpened}</td>
            <td>${shift.dateClosed}</td>
            <td>${shift.timeClosed}</td>
            <td>${shift.employee.name}</td>
            <td>
                <form action="/shifts/${shift.id}/update">
                    <input type="submit" value="Редактировать">
                </form>
            </td>
        </tr>

    </c:forEach>
</table>
<a href="/main">Назад</a>
</body>
</html>
