<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 13.11.2020
  Time: 00:08
  To change this template use File | Settings | File Templates.
--%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>

</head>
<body>
<form:form action="/login" method="post" modelAttribute="user">
    <form:input path="login"/>
    <br/>
    <form:input path="password"/>
    <br/>
    <p><input type="submit" value=Войти>
    </p>
    <p><select size="1" name="comObj">
        <option disabled selected>Выберите ТО</option>
        <c:forEach items="${commercialObjects}" var="commercialobject">
            <option value=${commercialobject.id}>${commercialobject.address}</option>
        </c:forEach>
    </select></p>
</form:form>
</body>
</html>
