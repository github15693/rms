// Initialize array book colection
var bookArr = libArray();

$(function () {
    $(document).on('click', '.selectBook', function () {
        selecBookChange($(this));
    });
});

function selecBookChange($this){
    var val = $this.val();
    if ($this.prop('checked') == true) {
        bookArr.insert(val);
    } else {
        bookArr.deletByValue(val);
    }
}
//function update booking status
//function updateBookStatus(id) {
//    var book_id = $('#' + id).data('id'), book_stt = $('#' + id).val()
//    $.post('/bookings/updateStatus', {book_id: book_id, book_stt: book_stt}, function (data) {
//        if (data.status == 'failed') {
//            delayedAlert('Failed!', 1000);
//        } else if (data.status == 'success') {
//            delayedAlert(i18nJs.common.update_success, 1000)
//        }
//
//    });
//}
function updateBookStatus(thiss){
    $this = $(thiss);
    var book_id = $this.data('id');
    var book_stt = $this.val();
//    var book_stt = $this.get(0).checked == true ? 'Booked' : '';
    $.post('/bookings/updateStatus', {book_id: book_id, book_stt: book_stt}, function (data) {
        if (data.status == 'failed') {
            delayedAlert(i18nJs.common.update_unsuccess, 1000);
        } else if (data.status == 'success') {
            delayedAlert(i18nJs.common.update_success, 1000)
        }

    });
}
// check empty booking
function checkEmptyBooking() {
    if (bookArr.getArray().length < 1) {
        delayedAlert('Colection is empty!', 1000);
        return false;
    } else {
        $.get('bookings/confirm');
    }
}
//function delete booking collection
function deleteBooking() {
    if (bookArr.getArray().length > 0) {
        $.post('/bookings/deleteColection', {book_id: bookArr.getArray()}, function (data) {
            if (data.status == 'success') {
                for (var i = 0; i < bookArr.getArray().length; i++) {
                    $('#' + bookArr.getArray()[i]).closest('tr').remove();
                }
                $('table.dataTable  tbody tr:even').css({ "background-color": "#f9f9f9"})
                $('table.dataTable  tbody tr:odd').css({ "background-color": "white"})
                $('table.dataTable  tbody .sorting_1:even').css({ "background-color": "#f1f1f1"})
                $('#booking-modal').modal('hide')
                delayedAlert(i18nJs.common.delete_success, 1000)
            }
        });
    }
}

//library array
function libArray() {
    var arr = [];
    return{
//        init:function(){
//            return arr =[]
//        },
        insert: function (val) {
            return arr[arr.length] = val;
        },
        deletByValue: function (val) {
            var index = arr.indexOf(val);
            arr.splice(index, 1)
        },
        getArray: function () {
            return arr;
        }
    }
};
//function alert message
function delayedAlert(msg, time) {
    $('#notifications').html("<div class='alert alert-success alert-dismissible' role='alert'><button type='button' class='close' data-dismiss='alert'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>" + msg + "</div>");
    setTimeout(function () {
        $('#notifications').html('');
    }, time);
};

