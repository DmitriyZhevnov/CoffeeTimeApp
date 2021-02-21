<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<main class='main'>
    <form action="/login" method="post" modelAttribute="user">
        <div class="main-data">
            <div class="main-data_personal">
                <input type="text" name="login" placeholder="Логин">
                <input type="password" name="password" placeholder="Пароль">
            </div>
            <div class='main-data_error'>${msg}</div>
            <button class='button' type="submit">Войти</button>
        </div>
    </form>
</main>
</body>
</html>


