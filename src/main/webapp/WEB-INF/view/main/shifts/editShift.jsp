<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
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
    <div class='shifts-second-section'>
        <div class='error'>Ошибка: данные введены некорректно</div>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div style="width: 1000px" class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Торговый объект</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Дата открытия</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Время открытия</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Дата закрытия</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Время закрытия</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Сотрудник</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
        </div>
        <form action="/shifts/${shift.id}/update" method="post">
            <div style="width: 1000px" class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <select class="myEdit" name="idCommercialObject">
                            <option disabled>${shift.commercialObject.address}</option>
                            <option hidden selected value="${shift.commercialObject.id}"></option>
                            <c:forEach items="${allCommercialObjects}" var="commercialObject">
                                <option value="${commercialObject.id}">${commercialObject.address}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input class="myEdit" type="date" name="dateOpened" value="${shift.dateOpened}">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input <input class="myEdit" type="time" name="timeOpened" value="${shift.timeOpened}">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input <input class="myEdit" type="date" name="dateClosed" value="${shift.dateClosed}">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input <input class="myEdit" type="time" name="timeClosed" value="${shift.timeClosed}">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <select <input class="myEdit" name="idEmployee">
                            <option disabled>${shift.employee.name}</option>
                            <option selected hidden value="${shift.employee.id}"></option>
                            <c:forEach items="${allEmployees}" var="employee">
                                <option value="${employee.id}">${employee.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <button
                                type="submit"
                                class='menuPage-section-products_button menuPage-section-products_button-edit'>
                            Сохранить
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</div>
</body>
</html>
