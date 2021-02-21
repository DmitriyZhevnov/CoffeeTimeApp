<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<main class='main'>
    <form action="/login/openShift" method="post">
        <div class='main-data'>
            <select class='main-data_select' size="1" name="comObj">
                <option disabled selected>Выберите ТО</option>
                <c:forEach items="${commercialObjects}" var="commercialobject">
                    <option value=${commercialobject.id}>${commercialobject.address}</option>
                </c:forEach>
            </select>
            <div class='main-data_error main-data_error-parametrs'>${msg}</div>
            <button class='button' type="submit">Открыть смену</button>
        </div>
    </form>
</main>
</body>
</html>