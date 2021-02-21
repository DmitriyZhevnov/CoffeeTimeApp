//Функция отображения PopUp
function PopUpNewUserShow() {
    $("#popup2").show();
}

function PopUpPayShow() {
    $("#popup1").show();
}

function PopUpDifferentTypeOfPaymentShow() {
    $("#popup3").show();
}
function PopUpNewUserHide() {
    $("#popup2").hide();
}

function PopUpPayHide() {
    $("#popup1").hide();
}

function PopUpDifferentTypeOfPaymentHide() {
    $("#popup3").hide();
}

function subForSecond() {
    var secondTextArea = document.getElementById('second');
    document.getElementById('first').value = (${totalCost} -secondTextArea.value).toFixed(2);
}

function subForFirst() {
    var firstTextArea = document.getElementById('first');
    document.getElementById('second').value = (${totalCost} -firstTextArea.value).toFixed(2);
}