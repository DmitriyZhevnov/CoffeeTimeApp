<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 15.02.2021
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<style>
    * {
        font-family: Areal;
    }

    .b-container {
        /*width: 300px;*/
        /*height: 300px;*/
        /*background-color: #ccc;*/
        /*margin: 0px auto;*/
        /*padding: 10px;*/
        /*font-size: 30px;*/
        color: #000000;
    }

    .b-popup {
        width: 100%;
        min-height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        overflow: hidden;
        position: fixed;
        top: 0px;
    }

    .b-popup .b-popup-content {
        margin: 40px auto 0px auto;
        width: 250px;
        height: 150px;
        padding: 10px;
        background-color: #c5c5c5;
        border-radius: 5px;
        box-shadow: 0px 0px 10px #000;
    }
</style>
<script src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
<script>
    $(document).ready(function () {
        PopUpNewItemHide();
    });

    function PopUpNewItemShow() {
        $("#popup8").show();
    }

    function PopUpNewItemHide() {
        $("#popup8").hide();
    }
</script>

<head>
    <title>Title</title>
</head>
<body>
<div class="b-container">
    <a href="javascript:PopUpNewItemShow()">Добавить новый</a>
</div>
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
    </tr>
    <tr>
        <th>Название</th>
        <th>Количество</th>
        <th>Единица измерения</th>
        <th></th>
    </tr>
    <c:forEach items="${allItems}" var="item">
        <tr>
            <td>${item.name}</td>
            <td>${item.quantityInWarehouse}</td>
            <td>${item.measure}</td>
            <td>
                <form action="/warehouse/${item.id}" method="get">
                    <input type="submit" value="Изменить">
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<div class="b-popup" id="popup8">
    <div class="b-popup-content">
        <form action="/warehouse/newItem" method="post">
            <p>Название: <textarea name="name" cols="15" rows="1"></textarea></p>
            <p>Единица измерения: <textarea name="measure" cols="15" rows="1"></textarea></p>
            <p>Количество на складе: <textarea name="quantityInWarehouse" cols="15" rows="1"></textarea></p>
            <input type="hidden" name="idProduct" value="${product.id}">
            <p><input type="submit" value=Добавить></p>
        </form>
        <a href="javascript:PopUpNewItemHide()">Назад</a>
    </div>
</div>
<a href="/main">Назад</a>
</body>
</html>
