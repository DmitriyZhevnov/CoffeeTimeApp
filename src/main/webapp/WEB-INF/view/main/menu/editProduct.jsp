<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
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

    function changeCount() {
        var firstTextArea = document.getElementById('countProd');
        document.getElementById('countProd2').value = firstTextArea.value;
    }
</script>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/menu">Назад</a>
            </div>
            <div class='header-data_user header-menuPage'>
                <a href="javascript:PopUpNewItemShow()">Добавить новый продукт на склад</a>
            </div>
        </div>
    </header>
    <form action="/menu/update" method="post">
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='error'>Ошибка: данные введены некорректно</div>
            <br/>
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Название</div>
                    <div>
                        <input class='menuPage-section-products' type="text" value="${product.name}" name="productName">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Цена</div>
                    <div>
                        <input class='menuPage-section-products' type="text" value="${product.price}"
                               name="productPrice">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Категория</div>
                    <div class='menuPage-section-products'>
                        <select style="width: 100%" class='menuPage-section-products_category' name="idCategory">
                            <option disabled>${product.category.name}</option>
                            <option selected hidden value="${product.category.id}"></option>
                            <c:forEach items="${allCategories}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                    <input hidden name="productId" value="${product.id}">
                    <button class='menuPage-section-products_button'>Сохранить</button>
                </div>
            </div>
        </div>
    </form>
    <div class='editProduct-second-section'>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='addNew'>
                <form action="/menu/${product.id}/addItem/" method="post">
                    <div>
                        <select class='addNew-ID' name="idItem">
                            <option selected disabled>Выберите</option>
                            <c:forEach items="${items}" var="item">
                                <option value="${item.id}">${item.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <button class='addNew-ID' style="color:#fa8f21" type="submit">Добавить</button>
                    </div>
                </form>
            </div>

            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Название</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Единица измерения</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Количество</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
            <c:forEach items="${composition}" var="comp">
                <div class='menuPage'>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>${comp.item.name}</div>
                    </div>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>${comp.item.measure}</div>
                    </div>
                    <div class='menuPage-section'>
                        <div><input id="countProd" oninput="changeCount()" class='menuPage-section-products' type="text"
                                    name="quantityOfItem"
                                    value="${comp.quantity}"></div>
                    </div>
                    <div class='menuPage-section-products'>
                        <div class='edit'>
                            <form action="/menu/updateComposition" method="post">
                                <button type="submit"
                                        class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                    Сохранить
                                </button>
                                <input type="hidden" id="countProd2" name="quantityOfItem">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="compositionId" value="${comp.id}">
                            </form>
                        </div>
                    </div>
                    <form action="/menu/${product.id}/removeItem" method="post">
                        <div class='edit'>
                            <input type="hidden" name="compositionId" value="${comp.id}">
                            <button type="submit"
                                    class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                Удалить
                            </button>
                        </div>
                    </form>
                    </form>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<div class="b-popup" id="popup7">
    <div class="menu-popup">
        <form action="/menu/newItem" method="post">
            <p align="right">Название: <textarea name="name" cols="15" rows="1"></textarea></p>
            <p align="right">Единица измерения: <textarea name="measure" cols="15" rows="1"></textarea></p>
            <p align="right">Количество на складе: <textarea name="quantityInWarehouse" cols="15" rows="1"></textarea>
            </p>
            <input type="hidden" name="idProduct" value="${product.id}">
            <p><input class="bottom-popup" type="submit" value=Добавить></p>
        </form>
        <p align="center"><a class="href-popup" href="javascript:PopUpNewItemHide()">Назад</a></p>
    </div>
</div>

</body>
</html>

