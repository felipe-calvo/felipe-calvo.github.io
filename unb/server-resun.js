var nomail = "<span class='error-msg'>Ingrese primero un correo electrónico</span>";
var ermail = "<span class='error-msg'>El correo ingresado no es válido.<br/>";
ermail += "Verifique su correo de registro y vuelva a intentarlo.</span>";
var LAURL = "https://script.google.com/macros/s/AKfycbzEp7ZCb24w853i6ME9WWH6Z-HpFbW6DJWBYVPeJJ_Aysu4BA/exec";

function anscallback(a) {
	$("#consulta").html(a);  
}

$(document).ready(function () {
    function validar_email(a) {
        var b = /[\w-\.]{3,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w-]{2,4}/;
        if (b.test(a)) return true;
        else return false
    }
    $("#cons").click(function () {
        var loading = '<img src="http://lh3.googleusercontent.com/-A6xlhPOOg_U/U0w-d2E_wXI/AAAAAAAAIqQ/MS7bIR4QpRE/s00/loading-results-unacademia.GIF" border="0" class="no" style="display:block;margin:0 auto;width:128px;height:128px;" />';
		$("#consulta").html(loading);
		var ansgivenmail = $("#given-mail").val().toLowerCase();
        if (ansgivenmail == '') {
            $("#consulta").html(nomail)
        } else if (validar_email(ansgivenmail)) {
            var parametros = "?prefix=anscallback&sim="+simvalue+"&email="+ansgivenmail+"";
            $.ajax({
                dataType: "jsonp",
                data: "",
                url: LAURL+parametros,
                success: function (a) {}
            })
        } else {
            $("#consulta").html(ermail)
        }
    })
});