<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<html>
<head>

</head>
<body>
Текущий пользователь:${shift.employee.name}
<br/>
Смена открыта: ${shift.timeOpened}
<br/>
Торговый объект: ${shift.commercialObject.address}
<br/>
<br/>
<table width="100%" height="80%">
    <tr>
        <td height="10%" valign="top" align="left">
            <form action="/newOrder" method="get">
                <input type="submit" value="Принять заказ">
            </form>
        </td>
        <sec:authorize access="hasRole('ADMIN')">
            <td valign="top" align="center">
                <form action="/shifts" method="get">
                    <input type="submit" value="Учет рабочего времени">
                </form>
            </td>
        </sec:authorize>
        <sec:authorize access="hasRole('USER')">
            <td></td>
        </sec:authorize>
        <td height="10%" valign="top" align="right">
            <form action="/main/closeShift" method="get">
                <input type="submit" value="Закрыть смену">
            </form>
        </td>
    </tr>
    <tr>
        <td height="10%" valign="top" align="left">
            <form action="/closedOrders" method="get">
                <input type="submit" value="Закрытые заказы">
            </form>
        </td>
        <sec:authorize access="hasRole('ADMIN')">
            <td height="10%" valign="top" align="center">
                <form action="/menu" method="get">
                    <input type="submit" value="Меню">
                </form>
            </td>
        </sec:authorize>
        <sec:authorize access="hasRole('USER')">
            <td></td>
        </sec:authorize>
        <td height="10%" valign="top" align="right">
            <form action="/report" method="get">
                <input type="submit" value="Отчёт">
            </form>
        </td>
    </tr>
    <sec:authorize access="hasRole('ADMIN')">
        <tr>
            <td height="70%"></td>
            <td height="70%" valign="top" align="center">
                <form action="/warehouse" method="get">
                    <input type="submit" value="Склад">
                </form>
            </td>
            <td height="70%"></td>
        </tr>
    </sec:authorize>
    <sec:authorize access="hasRole('USER')">
        <tr>
            <td height="70%"></td>
            <td height="70%"></td>
            <td height="70%"></td>
        </tr>
        <td></td>
    </sec:authorize>

    <tr>
        <td height="10%"></td>
        <td></td>
        <td height="10%" valign="top" align="right">
            <form action="/logout" method="GET">
                <input type="submit" value="Заблокировать">
            </form>
        </td>
    </tr>
</table>
</body>
</html>
