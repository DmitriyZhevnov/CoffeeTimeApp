<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 15.02.2021
  Time: 17:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/warehouse/${item.id}" method="post">
    <table>
        <tr>
            <th>Название</th>
            <th>Количество</th>
            <th>Единица измерения</th>
        </tr>
        <tr>
            <td><input type="text" value="${item.name}" name="itemName"></td>
            <td><input type="text" value="${item.quantityInWarehouse}" name="itemQuantity"></td>
            <td><input type="text" value="${item.measure}" name="itemMeasure"></td>
        </tr>
        <tr>
            <td colspan="4">
                <input type="submit" value="Сохранить изменения">
            </td>
        </tr>
    </table>
</form>
<a href="/warehouse">Назад</a>
</body>
</html>
