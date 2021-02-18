<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 15.02.2021
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="/main">Назад</a>
<table>
    <tr>
        <td colspan="4">
            <form action="/menu/newProduct" method="get">
                <p><input type="submit" value="Добавить новый"></p>
            </form>
        </td>
    </tr>
    <tr>
        <th>Название</th>
        <th>Цена</th>
        <th>Категория</th>
        <th></th>
    </tr>
    <c:forEach items="${allProducts}" var="product">
        <tr>
            <td>${product.name}</td>
            <td>${product.price}</td>
            <td>${product.category.name}</td>
            <td>
                <form action="/menu/${product.id}" method="get">
                    <p><input type="submit" value="Изменить"></p>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
