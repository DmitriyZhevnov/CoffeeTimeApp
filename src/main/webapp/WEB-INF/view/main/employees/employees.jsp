<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>

<div class='comObj-warehouse'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/main"><spring:message code="back"/></a>
            </div>
            <div class='header-data_user header-menuPage'>
                <a href="javascript:PopUpNewEmployeeShow()">
                    Новый сотрудник
                </a>
            </div>
        </div>
    </header>
</div>
<div class='error'>${msg}</div>
<div class='editProduct-second-section'>
    <table border="1" style="border: 5px double #fa8f21" width="600px">
        <tr>
            <td colspan="5" align="center" style="background: #fa8f21; font-size: 20px; font-weight: bold;">Трудоустроенные</td>
        </tr>
        <tr style="background: bisque">
            <td>Имя</td>
            <td>Логин</td>
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
                            <button class='myButton'>Сбросить пароль</button>
                        </div>
                    </form>
                </td>
                <td style="background: bisque">
                    <form action="/employees/${employee.id}/dismiss" method="post">
                        <input type="hidden" name="_method" value="patch">
                        <button class='myButton'>Уволить</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div class='editProduct-second-section'>
    <table border="1" style="border: 5px double #fa8f21" width="600px">
        <tr>
            <td colspan="5" align="center" style="background: #fa8f21; font-size: 20px; font-weight: bold;">Уволенные</td>
        </tr>
        <tr style="background: bisque">
            <td>Имя</td>
            <td>Логин</td>
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
                            <button class='myButton'>Вернуть</button>
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
            <p align="right">Имя: <textarea name="name" cols="20"
                                            rows="1"></textarea></p>
            <p align="right">Логин: <textarea name="login" cols="20"
                                              rows="1"></textarea></p>
            <p align="right">Пароль: <textarea name="password" cols="20"
                                               rows="1"></textarea></p>
            <p><input class="bottom-popup" type="submit" value=<spring:message code="newOrder.register"/>></p>
        </form>
        <p align="center"><a class="href-popup" href="javascript:PopUpNewEmployeeHide()"><spring:message
                code="newOrder.back"/></a></p>
    </div>
</div>


</body>
<script src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
<script>
    $(document).ready(function () {
        PopUpNewEmployeeHide();
    });

    function PopUpNewEmployeeShow() {
        $("#popup9").show();
    }

    function PopUpNewEmployeeHide() {
        $("#popup9").hide();
    }
</script>
</html>
