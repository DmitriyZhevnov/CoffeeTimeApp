<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 10.02.2021
  Time: 18:29
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
    <title>report</title>
</head>
<body>
<table border="1">
    <form action="/report/date" method="post">
        <p>Выберите объект:</p>
        <p>
            <select name="idCommercialObject">
                <c:forEach items="${allCommercialObjects}" var="commercialObject">
                    <option value="${commercialObject.id}">${commercialObject.address}</option>
                </c:forEach>
            </select>
        </p>
        <p>Выберите дату: </p>
        <p> С : <input type="date" id="first" name="fromDate" onchange="copyDate()" value="${fromDate}"></p>
        <p> По : <input type="date" id="second" name="toDate" value="${toDate}"></p>
        <p><input type="submit" value="Просмотр"></p>
    </form>
    <tr>
        <td>Всего</td>
        <td>${report.get(0)}</td>
    </tr>
    <tr>
        <td>Наличные</td>
        <td>${report.get(1)}</td>
    </tr>
    <tr>
        <td>Безналичные</td>
        <td>${report.get(2)}</td>
    </tr>
    <tr>
        <td>Чеков</td>
        <td>${report.get(3)}</td>
    </tr>
    <tr>
        <td>Отменено чеков</td>
        <td>${report.get(4)}</td>
    </tr>
</table>
<a href="/main">Назад</a>
</body>
</html>
