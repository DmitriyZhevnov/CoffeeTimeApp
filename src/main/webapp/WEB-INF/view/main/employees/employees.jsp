<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <title><spring:message code="employees"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/functions.js"></script>
</head>
<body>
<div class='background'>
    <div class='comObj-warehouse'>
        <header class='header header-menuPage'>
            <div class='header-data header-menuPage'>
                <div class='header-data_user header-menuPage'>
                    <a href="/main"><spring:message code="back"/></a>
                </div>
                <div class='header-data_user header-menuPage'>
                    <a href="javascript:PopUpNewEmployeeShow()">
                        <spring:message code="newEmployee"/>
                    </a>
                </div>
            </div>
        </header>
    </div>
    <div class='error'>${msg}</div>
    <div class='editProduct-second-section'>
        <table border="1" style="border: 5px double #fa8f21" width="600px">
            <tr>
                <td colspan="5" align="center" style="background: #fa8f21; font-size: 20px; font-weight: bold;">
                    <spring:message code="employed"/></td>
            </tr>
            <tr style="background: bisque">
                <td><spring:message code="employee.name"/></td>
                <td><spring:message code="login"/></td>
                <td></td>
                <td></td>
            </tr>
            <c:forEach items="${allEmployees}" var="employee">
                <tr>
                    <td>${employee.name}</td>
                    <td>${employee.login}</td>
                    <td style="background: bisque">
                        <form action="/employees/${employee.id}/updatePassword">
                            <div class='products'>
                                <button class='myButton'><spring:message code="reset.the.password"/></button>
                            </div>
                        </form>
                    </td>
                    <td style="background: bisque">
                        <form action="/employees/${employee.id}/dismiss" method="post">
                            <input type="hidden" name="_method" value="patch">
                            <button class='myButton'><spring:message code="dismiss"/></button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class='editProduct-second-section'>
        <table border="1" style="border: 5px double #fa8f21" width="600px">
            <tr>
                <td colspan="5" align="center" style="background: #fa8f21; font-size: 20px; font-weight: bold;">
                    <spring:message code="dismissed"/></td>
            </tr>
            <tr style="background: bisque">
                <td><spring:message code="employee.name"/></td>
                <td><spring:message code="login"/></td>
                <td></td>
            </tr>
            <c:forEach items="${dismissedEmployees}" var="employee">
                <tr>
                    <td>${employee.name}</td>
                    <td>${employee.login}</td>
                    <td style="background: bisque">
                        <form action="/employees/${employee.id}/return" method="post">
                            <input type="hidden" name="_method" value="patch">
                            <div class='products'>
                                <button class='myButton'><spring:message code="return"/></button>
                            </div>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="b-popup" id="popup9">
        <div class="b-popup-content">
            <form action="/employees" method="post">
                <p align="right"><spring:message code="employee.name"/>: <textarea name="name" cols="20"
                                                                                   rows="1"></textarea></p>
                <p align="right"><spring:message code="login"/>: <textarea name="login" cols="20"
                                                                           rows="1"></textarea></p>
                <p align="right"><spring:message code="password"/>: <textarea name="password" cols="20"
                                                                              rows="1"></textarea></p>
                <p><input class="bottom-popup" type="submit" value=<spring:message code="newOrder.register"/>></p>
            </form>
            <p align="center"><a class="href-popup" href="javascript:PopUpNewEmployeeHide()"><spring:message
                    code="newOrder.back"/></a></p>
        </div>
    </div>
</div>
</body>
</html>
