<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 15.02.2021
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
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
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/main">Назад</a>
            </div>
            <div class='header-data_user header-menuPage'>
                <a href="javascript:PopUpNewItemShow()">Добавить новый товар</a>
            </div>
        </div>
    </header>
    <div class='editProduct-second-section'>
        <div class='error'>Ошибка: данные введены некорректно</div>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='addNew addNew-column'>
                <form action="/warehouse/commercialObject" method="get">
                    <div>
                        <select class='addNew-ID' name="idCommercialObject">
                            <c:forEach items="${commercialObjects}" var="commercialObject">
                                <option value="${commercialObject.id}">${commercialObject.address}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <button type="submit" style="color:#fa8f21" class='addNew-ID'>Просмотр</button>
                    </div>
                </form>
            </div>
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Название</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Количество</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Единица измерения</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
        </div>
        <c:forEach items="${allItems}" var="item">
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${item.name}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${item.quantityInWarehouse}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${item.measure}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='edit'>
                        <form action="/warehouse/${item.id}" method="get">
                            <button
                                    type="submit"
                                    class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                Изменить
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="b-popup" id="popup8">
    <div class="menu-popup">
        <form action="/warehouse/newItem" method="post">
            <p align="right">Название: <textarea name="name" cols="15" rows="1"></textarea></p>
            <p align="right">Единица измерения: <textarea name="measure" cols="15" rows="1"></textarea></p>
            <p align="right">Количество на складе: <textarea name="quantityInWarehouse" cols="15" rows="1"></textarea></p>
            <p><input class="bottom-popup" type="submit" value=Добавить></p>
        </form>
        <p align="center"><a class="href-popup" href="javascript:PopUpNewItemHide()">Назад</a></p>
    </div>
</div>

</body>
</html>

