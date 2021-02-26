<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/employees">Назад</a>
            </div>
        </div>
    </header>
    <div class='editProduct-second-section'>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='reportPage'>
                <div class='reportPage-section'>
                    <div class='menuPage-section-block'>Имя</div>
                    <div class='menuPage-section-block'>Логин</div>
                    <div class='menuPage-section-block'>Пароль</div>
                    <div class='menuPage-section-block'></div>
                </div>
                <div class='reportPage-section'>
                    <form action="/employees/${employee.id}/updatePassword" method="post">
                        <input type="hidden" name="_method" value="patch">
                        <div class='menuPage-report-section'>${employee.name}</div>
                        <div class='menuPage-report-section'>${employee.login}</div>
                        <div class='menuPage-report-section'>
                            <input class="myEdit" type="text" name="password">
                        </div>
                        <div class='menuPage-report-section'>
                            <button class='myButton'>Сохранить</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
