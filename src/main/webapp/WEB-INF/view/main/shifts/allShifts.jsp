<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<sec:authorize access="hasRole('ADMIN')">--%>
<%--</sec:authorize>--%>
<!DOCTYPE html>
<head>
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<script>
    function copyDate() {
        var fromDate = document.getElementById('first');
        document.getElementById('second').value = fromDate.value;
    }
</script>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/main">Назад</a>
            </div>

            <div class='header-data_user header-menuPage'>
                ${totalTime}
            </div>
        </div>
    </header>
    <div class='shifts-second-section'>
        <div class='error'>Ошибка: данные введены некорректно</div>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='addNew-shifts addNew-column'>
                <form action="/shifts/date" method="post">
                    <div>
                        <select class='addNew-ID' name="idEmployee">
                            <c:forEach items="${allEmployees}" var="employee">
                                <option value="${employee.id}">${employee.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>с: <input type="date" onchange="copyDate()" class='addNew-ID' id="first" name="fromDate"
                                   value="${fromDate}"></div>
                    <div>по: <input type="date" class='addNew-ID' id="second" name="toDate" value="${toDate}"></div>
                    <div>
                        <button type="submit" style="color:#fa8f21" class='addNew-ID'>Показать</button>
                    </div>
                </form>
            </div>
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
        <c:forEach items="${shifts}" var="shift">
            <div style="width: 1000px" class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${shift.commercialObject.address}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${shift.dateOpened}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${shift.timeOpened}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${shift.dateClosed}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${shift.timeClosed}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>${shift.employee.name}</div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <form action="/shifts/${shift.id}/update">
                            <button
                                    type="submit"
                                    class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                Редактировать
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






