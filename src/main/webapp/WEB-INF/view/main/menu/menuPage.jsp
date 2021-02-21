<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

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
        </div>
    </header>
    <div class='editProduct-second-section'>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='addNew addNew-column'>
                <form action="/menu/newProduct" method="get">
                    <button
                            style="color: white"
                            type="submit"
                            class='menuPage-section-products_button menuPage-section-products_button-edit'>
                        Добавить новый товар
                    </button>
                </form>
            </div>
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Название</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Цена</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Категория</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
        </div>
        <c:forEach items="${allProducts}" var="product">
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${product.name}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${product.price}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${product.category.name}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='edit'>
                        <form action="/menu/${product.id}" method="get">
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
</div>
</body>
</html>
