<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 15.02.2021
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="/warehouse">На главный склад</a>
<table>
    <tr>
        <td colspan="4">
            <form action="/warehouse/commercialObject/" method="get">
                <p>Выберите объект:</p>
                <p>
                    <select name="idCommercialObject">
                        <c:forEach items="${commercialObjects}" var="commercialObject">
                            <option value="${commercialObject.id}">${commercialObject.address}</option>
                        </c:forEach>
                    </select>
                    <input type="submit" value="Просмотр"></p>
                </p>

            </form>
        </td>
        <td>
            <form action="/warehouse/commercialObject/${commObject.id}/addItem" method="post">
                <select name="idItem">
                    <option selected disabled>Выберите</option>
                    <c:forEach items="${items}" var="item">
                        <option value="${item.id}">${item.name}</option>
                    </c:forEach>
                </select>
                <input type="submit" value="Добавить">
            </form>
        </td>
    </tr>
    <tr>
        <th>Название</th>
        <th>Единица измерения</th>
        <th>Количество</th>
        <th></th>
    </tr>
    <c:forEach items="${commObject.commercialObjectQuantityOfItems}" var="item">
        <form action="/warehouse/commercialObject/${item.id}" method="post">
            <tr>
                <td>${item.items.get(0).name}</td>

                <td>${item.items.get(0).measure}</td>
                <td>
                    <input type="text"
                           value="<fmt:formatNumber type="number" maxFractionDigits="2" value="${item.quantity}"/>"
                           name="itemQuantity">
                </td>
                <td>
                    <input type="submit" value="Сохранить">
                </td>
            </tr>
            <input type="hidden" name="idCommercialObject" value="${item.commercialObject.id}">
        </form>
    </c:forEach>
</table>
<a href="/warehouse">Назад</a>
</body>
</html>
