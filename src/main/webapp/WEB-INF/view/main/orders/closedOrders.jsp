<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--<sec:authorize access="hasRole('ADMIN')">--%>
<%--</sec:authorize>--%>
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
        <div class='error'>Ошибка: данные введены некорректно</div>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='addNew addNew-column'>
                <form action="/closedOrders/date" method="post">
                    <div>
                        <select class='addNew-ID' name="idCommercialObject">
                            <c:forEach items="${allCommercialObjects}" var="commercialObject">
                                <option value="${commercialObject.id}">${commercialObject.address}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div><input type="date" class='addNew-ID' name="date" value="${date}"></div>
                    <div>
                        <button type="submit" style="color:#fa8f21" class='addNew-ID'>Просмотр</button>
                    </div>
                </form>
            </div>
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Время</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Итоговая сумма</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Сотрудник</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>Информация</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
        </div>
        <c:forEach items="${orders}" var="order">
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${order.time}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${order.cardAmount + order.cashAmount}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${order.shift.employee.name}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='edit'>${order.info}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='edit'>
                        <form action="/closedOrders/${order.id}" method="get">
                            <button
                                    type="submit"
                                    class='menuPage-section-products_button menuPage-section-products_button-edit'>Инфо
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


