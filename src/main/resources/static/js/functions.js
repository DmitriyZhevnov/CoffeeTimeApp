function PopUpNewUserShow() {
    document.getElementById("popup2").style.display = 'block';
}

function PopUpPayShow() {
    document.getElementById("popup1").style.display = 'block';
}

function PopUpDifferentTypeOfPaymentShow() {
    document.getElementById("popup3").style.display = 'block';
}

function PopUpNewUserHide() {
    document.getElementById("popup2").style.display = 'none';
}

function PopUpPayHide() {
    document.getElementById("popup1").style.display = 'none';
}

function PopUpDifferentTypeOfPaymentHide() {
    document.getElementById("popup3").style.display = 'none';
}

function PopUpNewEmployeeShow() {
    document.getElementById("popup9").style.display = 'block';
}

function PopUpNewEmployeeHide() {
    document.getElementById("popup9").style.display = 'none';
}

function subForSecond(total) {
    var secondTextArea = document.getElementById('second');
    document.getElementById('first').value = (total -secondTextArea.value).toFixed(2);
}

function subForFirst(total) {
    var firstTextArea = document.getElementById('first');
    document.getElementById('second').value = (total -firstTextArea.value).toFixed(2);
}

function changeCount(number, index) {
    let tt = document.getElementById('countProd2').value = number;
    let gg = document.getElementsByName("quantityOfItem")[index];
    gg.value = tt;
}

/////////

function PopUpCancelOrderShow() {
    document.getElementById("popup4").style.display = 'block';
}

function PopUpCancelOrderHide() {
    document.getElementById("popup4").style.display = 'none';
}

function PopUpChangePaymentTypeShow() {
    document.getElementById("popup5").style.display = 'block';
}

function PopUpChangePaymentTypeHide() {
    document.getElementById("popup5").style.display = 'none';
}

function PopUpChangeToDifferentPaymentTypeShow() {
    document.getElementById("popup6").style.display = 'block';
}

function PopUpChangeToDifferentPaymentTypeHide() {
    document.getElementById("popup6").style.display = 'none';
}

function copyDate() {
    var fromDate = document.getElementById('firstDate');
    document.getElementById('secondDate').value = fromDate.value;
}
function PopUpNewItemShow() {
    document.getElementById("popup8").style.display = 'block';
}

function PopUpNewItemHide() {
    document.getElementById("popup8").style.display = 'none';
}
