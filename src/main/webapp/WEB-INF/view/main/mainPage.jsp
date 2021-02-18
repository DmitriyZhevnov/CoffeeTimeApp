<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<html>
<head>

</head>
<body>
<br/>
<table width="100%" height="80%">
    <tr>
        <td height="10%" valign="top" align="left">
            <form action="/newOrder" method="get">
                <input type="submit" value="Принять заказ">
            </form>
        </td>
        <td valign="top" align="center">
            <form action="/shifts" method="get">
                <input type="submit" value="Учет рабочего времени">
            </form>
        </td>
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
        <td height="10%" valign="top" align="center">
            <form action="/menu" method="get">
                <input type="submit" value="Меню">
            </form>
        </td>

        <td height="10%" valign="top" align="right">
            <form action="/report" method="get">
                <input type="submit" value="Отчёт">
            </form>
        </td>
    </tr>
    <tr>
        <td height="70%"></td>
        <td height="70%" valign="top" align="center">
            <form action="/warehouse" method="get">
                <input type="submit" value="Склад">
            </form>
        </td>
        <td height="70%"></td>
    </tr>
    <tr>
        <td height="10%"></td>
        <td></td>
        <td height="10%" valign="top" align="right">
            <form action="/main/block" method="get">
                <input type="submit" value="Заблокировать">
            </form>
        </td>
    </tr>
</table>
</body>
</html>
