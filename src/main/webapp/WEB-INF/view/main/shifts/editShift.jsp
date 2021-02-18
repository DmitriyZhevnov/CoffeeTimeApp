<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 14.02.2021
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/shifts/${shift.id}/update" method="post">
    <table>
        <tr>
            <td>Торговый объект:</td>
            <td>
                <select name="idCommercialObject">
                    <option disabled>${shift.commercialObject.address}</option>
                    <option hidden selected value="${shift.commercialObject.id}"></option>
                    <c:forEach items="${allCommercialObjects}" var="commercialObject">
                        <option value="${commercialObject.id}">${commercialObject.address}</option>
                    </c:forEach>
                </select>
            </td>
            <td>
                Сотрудник:
            </td>
            <td>
                <select name="idEmployee">
                    <option disabled >${shift.employee.name}</option>
                    <option selected hidden value="${shift.employee.id}"></option>
                    <c:forEach items="${allEmployees}" var="employee">
                        <option value="${employee.id}">${employee.name}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <td>Дата открытия:</td>
            <td><input type="date" name="dateOpened" value="${shift.dateOpened}"></td>
            <td>Время открытия:</td>
            <td><input type="time" name="timeOpened" value="${shift.timeOpened}"></td>
        </tr>
        <tr>
            <td>Дата закрытия:</td>
            <td><input type="date" name="dateClosed" value="${shift.dateClosed}"></td>
            <td>Время закрытия:</td>
            <td><input type="time" name="timeClosed" value="${shift.timeClosed}"></td>
        </tr>
        <tr>
            <td colspan="4">
                <input type="submit" value="Сохранить">
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <a href="/shifts">Назад</a>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
