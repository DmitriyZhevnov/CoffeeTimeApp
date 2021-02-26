<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <title><spring:message code="shift.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/shifts"><spring:message code="back"/></a>
            </div>
        </div>
    </header>
    <div class='shifts-second-section'>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div style="width: 1000px" class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="shifts.tradingObject"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="shifts.dateOpened"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="shifts.timeOpened"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="shifts.dateClosed"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="shifts.timeClosed"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="employee"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
        </div>
        <form action="/shifts/${shift.id}/update" method="post">
            <input type="hidden" name="_method" value="patch">
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
                        <input class="myEdit" type="time" name="timeOpened" value="${shift.timeOpened}">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input class="myEdit" type="date" name="dateClosed" value="${shift.dateClosed}">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <input class="myEdit" type="time" name="timeClosed" value="${shift.timeClosed}">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-products'>
                        <select class="myEdit" name="idEmployee">
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
                            <spring:message code="save"/>
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
