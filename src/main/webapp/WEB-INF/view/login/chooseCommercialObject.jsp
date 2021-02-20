<%--
  Created by IntelliJ IDEA.
  User: Жевновы
  Date: 20.02.2021
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/login/openShift" method="post">
    <p><select size="1" name="comObj">
        <option disabled selected>Выберите ТО</option>
        <c:forEach items="${commercialObjects}" var="commercialobject">
            <option value=${commercialobject.id}>${commercialobject.address}</option>
        </c:forEach>
    </select></p>
    <input type="submit" value="Открыть смену">
</form>

</body>
</html>
