<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<head>
    <title><spring:message code="shifts.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/main">
                    <spring:message code="back"/>
                </a>
            </div>

            <div class='header-data_user header-menuPage'>
                ${totalTime}
            </div>
        </div>
    </header>
    <div class='shifts-second-section'>
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
                    <div><spring:message code="shifts.from"/>: <input type="date" onchange="copyDate()"
                                                                      class='addNew-ID' id="first" name="fromDate"
                                                                      value="${fromDate}"></div>
                    <div><spring:message code="shifts.to"/>: <input type="date" class='addNew-ID' id="second"
                                                                    name="toDate" value="${fromDate}"></div>
                    <div>
                        <button type="submit" style="color:#fa8f21" class='addNew-ID'><spring:message
                                code="view"/></button>
                    </div>
                </form>
            </div>
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
                                <spring:message code="edit"/>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
<script>
    function copyDate() {
        var fromDate = document.getElementById('first');
        document.getElementById('second').value = fromDate.value;
    }
</script>
</html>



