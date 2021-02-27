<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
    <title>AccessDenied page</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<header class='header header-menuPage'>
    <div class='header-data header-menuPage'>
        <div class='header-data_user header-menuPage'>
            <a href="/main">To main page</a>
        </div>
    </div>
</header>
<main class='main-choose'>
    <form action="/login/openShift" method="post">
        <div class='main-data'>
                <div class='main-data_error main-data_error-parametrs'>
                    <p>You don't have access to this page.</p>
                    <p>У вас нет прав для доступа к этой странице.</p>
                </div>
        </div>
    </form>
</main>
</body>
</html>