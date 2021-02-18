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
        $("#popup7").show();
    }
    function PopUpNewItemHide() {
        $("#popup7").hide();
    }
</script>
<head>
    <title>Title</title>
</head>
<body>
<form action="/menu/update" method="post">
    <table>
        <tr>
            <th>Название</th>
            <th>Цена</th>
            <th>Категория</th>
        </tr>
        <tr>
            <td><input type="text" value="${product.name}" name="productName"></td>
            <td><input type="text" value="${product.price}" name="productPrice"></td>
            <td><select name="idCategory">
                <option disabled>${product.category.name}</option>
                <option selected hidden value="${product.category.id}"></option>
                <c:forEach items="${allCategories}" var="category">
                    <option value="${category.id}">${category.name}</option>
                </c:forEach>
            </select></td>
        </tr>
        <tr>
            <td colspan="4">
                <input hidden name="productId" value="${product.id}">
                <input type="submit" value="Сохранить изменения">
            </td>
        </tr>
    </table>
</form>


<form action="/menu/${product.id}/addItem/" method="post">
    <select name="idItem">
        <option selected disabled>Выберите</option>
        <c:forEach items="${items}" var="item">
            <option value="${item.id}">${item.name}</option>
        </c:forEach>
    </select>
    <input type="submit" value="Добавить">
</form>


<div class="b-container">
    <a href="javascript:PopUpNewItemShow()">Добавить новый</a>
</div>
<div class="b-popup" id="popup7">
    <div class="b-popup-content">
        <form action="/menu/newItem" method="post">
            <p>Название: <textarea name="name" cols="15" rows="1"></textarea></p>
            <p>Единица измерения: <textarea name="measure" cols="15" rows="1"></textarea></p>
            <p>Количество на складе: <textarea name="quantityInWarehouse" cols="15" rows="1"></textarea></p>
            <input type="hidden" name="idProduct" value="${product.id}">
            <p><input type="submit" value=Добавить></p>
        </form>
        <a href="javascript:PopUpNewItemHide()">Назад</a>
    </div>
</div>


<table>
    <tr>
        <th>Название</th>
        <th>Единица измерения</th>
        <th>Количество</th>
        <th></th>
        <th></th>
    </tr>
    <c:forEach items="${composition}" var="comp">
        <tr>
            <form action="/menu/updateComposition" method="post">
                <td>${comp.item.name}</td>
                <td>${comp.item.measure}</td>
                <td><input type="text" name="quantityOfItem" value="${comp.quantity}"></td>
                <td>
                    <input type="submit" value="Сохранить">
                </td>
                <input type="hidden" name="productId" value="${product.id}">
                <input type="hidden" name="compositionId" value="${comp.id}">
            </form>
            <form action="/menu/${product.id}/removeItem" method="post">
                <td>
                    <input type="hidden" name="compositionId" value="${comp.id}">
                    <input type="submit" value="Удалить">
                </td>
            </form>
        </tr>
    </c:forEach>
</table>
<a href="/menu">Назад</a>
</body>
</html>
