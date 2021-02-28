<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<head>
    <title><spring:message code="warehouse.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/functions.js"></script>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/main"><spring:message code="back"/></a>
            </div>
            <div class='header-data_user header-menuPage'>
                <a href="javascript:PopUpNewItemShow()"><spring:message code="warehouse.addNewProduct"/></a>
            </div>
        </div>
    </header>
    <div class='editProduct-second-section'>
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
                        <button type="submit" style="color:#fa8f21" class='addNew-ID'><spring:message
                                code="view"/></button>
                    </div>
                </form>
            </div>
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
                                <spring:message code="change"/>
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
            <p align="right"><spring:message code="name"/>: <textarea name="name" cols="15" rows="1"></textarea></p>
            <p align="right"><spring:message code="measure"/>: <textarea name="measure" cols="15"
                                                                         rows="1"></textarea>
            </p>
            <p align="right"><spring:message code="warehouse.quantityInWarehouse"/>: <textarea
                    name="quantityInWarehouse" cols="15" rows="1"></textarea></p>
            <p><input class="bottom-popup" type="submit" value=<spring:message code="add"/>></p>
        </form>
        <p align="center"><a class="href-popup" href="javascript:PopUpNewItemHide()"><spring:message
                code="back"/></a>
        </p>
    </div>
</div>
</body>
</html>

