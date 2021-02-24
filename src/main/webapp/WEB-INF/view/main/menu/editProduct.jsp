<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><spring:message code="menuEdit.title"/></title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
</head>
<script>
    function changeCount(number, index) {
        let tt = document.getElementById('countProd2').value = number;
        let gg = document.getElementsByName("quantityOfItem")[index];
        gg.value = tt;
    }
</script>
<body>
<div class='background'>
    <header class='header header-menuPage'>
        <div class='header-data header-menuPage'>
            <div class='header-data_user header-menuPage'>
                <a href="/menu"><spring:message code="back"/></a>
            </div>
        </div>
    </header>
    <form action="/menu/update" method="post">
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='error'>${msg}</div>
            <br/>
            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="name"/></div>
                    <div>
                        <input class='menuPage-section-products' type="text" value="${product.name}" name="productName">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="price"/></div>
                    <div>
                        <input class='menuPage-section-products' type="text" value="${product.price}"
                               name="productPrice">
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="category"/></div>
                    <div class='menuPage-section-products'>
                        <select style="width: 100%" class='menuPage-section-products_category' name="idCategory">
                            <option disabled>${product.category.name}</option>
                            <option selected hidden value="${product.category.id}"></option>
                            <c:forEach items="${allCategories}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                    <input hidden name="productId" value="${product.id}">
                    <button class='menuPage-section-products_button'><spring:message code="save"/></button>
                </div>
            </div>
        </div>
    </form>
    <div class='editProduct-second-section'>
        <div class='main main-menuPage main-menuPage_editProduct'>
            <div class='addNew'>
                <form action="/menu/${product.id}/addItem/" method="post">
                    <div>
                        <select class='addNew-ID' name="idItem">
                            <option selected disabled><spring:message code="select"/></option>
                            <c:forEach items="${items}" var="item">
                                <option value="${item.id}">${item.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <button class='addNew-ID' style="color:#fa8f21" type="submit">
                            <spring:message code="add"/>
                        </button>
                    </div>
                </form>
            </div>

            <div class='menuPage'>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'><spring:message code="name"/></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>
                        <spring:message code="measure"/>
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'>
                        <spring:message code="count"/>
                    </div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
                <div class='menuPage-section'>
                    <div class='menuPage-section-block'></div>
                </div>
            </div>
            <c:forEach items="${composition}" var="comp">
                <div class='menuPage'>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>${comp.item.name}</div>
                    </div>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>${comp.item.measure}</div>
                    </div>
                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>
                            <input class="myEdit" oninput="changeCount(this.value, ${composition.indexOf(comp)})"
                                   type="text"
                                   value="${comp.quantity}">
                        </div>
                    </div>

                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>
                            <form action="/menu/updateComposition" method="post">
                                <button type="submit"
                                        class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                    <spring:message code="save"/>
                                </button>
                                <input type="hidden" id="countProd2">
                                <input type="hidden" name="quantityOfItem">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="compositionId" value="${comp.id}">
                            </form>
                        </div>
                    </div>

                    <div class='menuPage-section'>
                        <div class='menuPage-section-products'>
                            <form action="/menu/${product.id}/removeItem" method="post">
                                <div class='edit'>
                                    <input type="hidden" name="compositionId" value="${comp.id}">
                                    <button type="submit"
                                            class='menuPage-section-products_button menuPage-section-products_button-edit'>
                                        <spring:message code="delete"/>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                        <%--                    <div class='menuPage-section'>--%>
                        <%--                        <div class='menuPage-section-products'>${comp.item.measure}</div>--%>
                        <%--                    </div>--%>
                        <%--                    <div class='menuPage-section'>--%>
                        <%--                        <div><input id="countProd" oninput="changeCount()" class='menuPage-section-products' type="text"--%>
                        <%--                                    name="quantityOfItem"--%>
                        <%--                                    value="${comp.quantity}"></div>--%>
                        <%--                    </div>--%>
                        <%--                    --%>


                        <%--                    <div class='menuPage-section-products'>--%>
                        <%--                        <div class='edit'>--%>
                        <%--                                                    <button type="submit"--%>
                        <%--                                                            class='menuPage-section-products_button menuPage-section-products_button-edit'>--%>
                        <%--                                                        <spring:message code="save"/>--%>
                        <%--                                                    </button>--%>
                        <%--                                                                                        <input type="text" id="countProd2" name="quantityOfItem">--%>
                        <%--                                                    <input type="hidden" name="productId" value="${product.id}">--%>
                        <%--                                                    <input type="hidden" name="compositionId" value="${comp.id}">--%>
                        <%--                                                    </form>--%>
                        <%--                                                </div>--%>
                        <%--                    </div>--%>
                        <%--                    <div class='menuPage-section-products'>--%>
                        <%--                        <div class='edit'>--%>
                        <%--                                                    <form action="/menu/${product.id}/removeItem" method="post">--%>
                        <%--                                                        <div class='edit'>--%>
                        <%--                                                            <input type="hidden" name="compositionId" value="${comp.id}">--%>
                        <%--                                                            <button type="submit"--%>
                        <%--                                                                    class='menuPage-section-products_button menuPage-section-products_button-edit'>--%>
                        <%--                                                                <spring:message code="delete"/>--%>
                        <%--                                                            </button>--%>
                        <%--                                                        </div>--%>
                        <%--                                                    </form>--%>
                        <%--                        </div>--%>
                        <%--                    </div>--%>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>

