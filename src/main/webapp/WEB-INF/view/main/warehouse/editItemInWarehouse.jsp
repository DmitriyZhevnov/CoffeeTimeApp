<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <title><spring:message code="warehouse.editItemWarehouseTitle"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/warehouse"><spring:message code="back"/></a>
            </div>
        </div>
    </header>

    <div class='editProduct-second-section'>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="name"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="count"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="measure"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
        </div>
        <form action="/warehouse/${item.id}" method="post">
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input class="edit-comObj" type="text" value="${item.name}" name="itemName">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input class="edit-comObj" type="text" value="${item.quantityInWarehouse}" name="itemQuantity">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input class="edit-comObj" type="text" value="${item.measure}" name="itemMeasure">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='edit'>
                        <form action="/warehouse/${item.id}" method="get">
                            <button
                                    type="submit"
                                    class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                <spring:message code="save"/>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>