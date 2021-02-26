<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <title><spring:message code="warehouse.comObjTitle"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class='comObj-warehouse'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <sec:authorize access="hasRole('USER')">
                <div class='header-data_user header-menuPage'>
                    <a href="/main"><spring:message code="back"/></a>
                </div>
                <div class='header-data_user header-menuPage'>
                    <spring:message code="warehouse.comObjTitle"/> ${commObject.address}
                </div>
            </sec:authorize>
            <sec:authorize access="hasRole('ADMIN')">
                <div class='header-data_user header-menuPage'>
                    <a href="/warehouse"><spring:message code="back"/></a>
                </div>
                <div class='header-data_user header-menuPage'>
                    <spring:message code="warehouse.comObjTitle"/> ${commObject.address}
                </div>
                <div class='header-data_user header-menuPage'>
                    <a href="/warehouse"><spring:message code="warehouse.toMainWarehouse"/></a>
                </div>
            </sec:authorize>
        </div>
    </header>
    <div class='editProduct-second-section'>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <sec:authorize access="hasRole('ADMIN')">
                <div class='addNew addNew-row'>
                    <form action="/warehouse/commercialObject" method="get">
                        <div>
                            <select class='addNew-ID' name="idCommercialObject">
                                <c:forEach items="${commercialObjects}" var="commercialObject">
                                    <option value="${commercialObject.id}">${commercialObject.address}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <button type="submit" style="color:#fa8f21" class='addNew-ID'><spring:message
                                    code="view"/></button>
                        </div>
                    </form>
                    <form action="/warehouse/commercialObject/${commObject.id}/addItem" method="post">
                        <div>
                            <select class='addNew-ID' name="idItem">
                                <option selected disabled>Выберите товар</option>
                                <c:forEach items="${items}" var="item">
                                    <option value="${item.id}">${item.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <button type="submit" style="color:#fa8f21" class='addNew-ID'><spring:message
                                    code="add"/></button>
                        </div>
                    </form>
                </div>
            </sec:authorize>
            <sec:authorize access="hasRole('ADMIN')">
                <div class='menuPage'>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-block'><spring:message code="name"/></div>
                    </div>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-block'><spring:message code="measure"/></div>
                    </div>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-block'><spring:message code="count"/></div>
                    </div>

                    <div class='menuPage-section'>
                        <div class='menuPage-section-block'></div>
                    </div>
                </div>
            </sec:authorize>
            <sec:authorize access="hasRole('USER')">
                <div class='userMenuPage'>
                    <div class='userMenuPage-section'>
                        <div class='menuPage-section-block'><spring:message code="name"/></div>
                    </div>
                    <div class='userMenuPage-section'>
                        <div class='menuPage-section-block'><spring:message code="measure"/></div>
                    </div>
                    <div class='userMenuPage-section'>
                        <div class='menuPage-section-block'><spring:message code="count"/></div>
                    </div>
                </div>
            </sec:authorize>
        </div>
        <c:forEach items="${commObject.commercialObjectQuantityOfItems}" var="item">
            <sec:authorize access="hasRole('ADMIN')">
                <form action="/warehouse/commercialObject/${item.id}" method="post">
                    <div class='menuPage'>
                        <div class='menuPage-section'>
                            <div class='menuPage-section-products'>${item.items.get(0).name}</div>
                        </div>
                        <div class='menuPage-section'>
                            <div class='menuPage-section-products'>${item.items.get(0).measure}</div>
                        </div>
                        <div class='menuPage-section'>
                            <div class='menuPage-section-products'>
                                <input class="edit-comObj" type="text"
                                       value="<fmt:formatNumber type="number" maxFractionDigits="2" value="${item.quantity}"/>"
                                       name="itemQuantity">
                            </div>
                        </div>
                        <div class='menuPage-section'>
                            <div class='edit'>
                                <button type="submit"
                                        class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                    <spring:message code="save"/>
                                </button>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="idCommercialObject" value="${item.commercialObject.id}">
                </form>
            </sec:authorize>
            <sec:authorize access="hasRole('USER')">
                <div class='userMenuPage'>
                    <div class='userMenuPage-section'>
                        <div class='menuPage-section-products'>${item.items.get(0).name}</div>
                    </div>
                    <div class='userMenuPage-section'>
                        <div class='menuPage-section-products'>${item.items.get(0).measure}</div>
                    </div>
                    <div class='userMenuPage-section'>
                        <div class='menuPage-section-products'>
                            <div class='menuPage-section-products'><fmt:formatNumber type="number" maxFractionDigits="2"
                                                                                     value="${item.quantity}"/></div>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="idCommercialObject" value="${item.commercialObject.id}">
            </sec:authorize>
        </c:forEach>
    </div>
</div>
</body>
</html>