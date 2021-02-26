<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <title><spring:message code="report.title"/></title>
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
            <sec:authorize access="hasRole('ADMIN')">
                <div class='addNew addNew-column'>
                    <form action="/report/date" method="post">
                        <div>
                            <select class='addNew-ID' name="idCommercialObject">
                                <c:forEach items="${allCommercialObjects}" var="commercialObject">
                                    <option value="${commercialObject.id}">${commercialObject.address}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div><spring:message code="shifts.from"/>: <input type="date" onchange="copyDate()"
                                                                          class='addNew-ID' id="first" name="fromDate"
                                                                          value="${fromDate}"></div>
                        <div><spring:message code="shifts.to"/>: <input type="date" class='addNew-ID' id="second"
                                                                        name="toDate" value="${toDate}"></div>
                        <div>
                            <button type="submit" style="color:#fa8f21" class='addNew-ID'>
                                <spring:message code="view"/>
                            </button>
                        </div>
                    </form>
                </div>
            </sec:authorize>
            <div class='reportPage'>
                <div class='reportPage-section'>
                    <div class='menuPage-section-block'><spring:message code="report.total"/></div>
                    <div class='menuPage-section-block'><spring:message code="newOrder.cash"/></div>
                    <div class='menuPage-section-block'><spring:message code="newOrder.card"/></div>
                    <div class='menuPage-section-block'><spring:message code="report.checks"/></div>
                    <div class='menuPage-section-block'><spring:message code="report.canceledChecks"/></div>
                </div>
                <div class='reportPage-section'>
                    <div class='menuPage-report-section'>${report.get(0)}</div>
                    <div class='menuPage-report-section'>${report.get(1)}</div>
                    <div class='menuPage-report-section'>${report.get(2)}</div>
                    <div class='menuPage-report-section'>${report.get(3)}</div>
                    <div class='menuPage-report-section'>${report.get(4)}</div>
                </div>
            </div>
        </div>
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