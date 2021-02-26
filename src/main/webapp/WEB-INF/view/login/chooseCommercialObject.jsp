<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <title><spring:message code="chooseComObj.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<header class='header_choose'>
    <div class='header-data'>
        <div class='header-data_user'></div>
        <div class='header-data_user'></div>
        <div class='header-data_user'></div>
        <div>
            <a title="English" href="?lang=en">
                <img src="<c:url value="/images/uk.jpg"/>" width="30px" height="30px" class="round">
            </a>
            <a title="Russian" href="?lang=ru">
                <img src="<c:url value="/images/ru.png"/>" width="30px" height="30px" class="round">
            </a>
        </div>
    </div>
</header>
<main class='main-choose'>
    <form action="/login/openShift" method="post">
        <div class='main-data'>
            <sec:authorize access="hasAnyRole('ADMIN', 'USER')">
                <select class='main-data_select' size="1" name="comObj">
                    <option disabled selected><spring:message code="chooseComObj.choose"/></option>
                    <c:forEach items="${commercialObjects}" var="commercialobject">
                        <option value=${commercialobject.id}>${commercialobject.address}</option>
                    </c:forEach>
                </select>
                <div class='main-data_error main-data_error-parametrs'>${msg}</div>
                <button class='button' type="submit"><spring:message code="chooseComObj.openShift"/></button>
            </sec:authorize>
            <sec:authorize access="hasRole('DISMISSED')">
                <div class='main-data_error main-data_error-parametrs'>Sorry</div>
            </sec:authorize>
        </div>
    </form>
</main>
</body>
</html>