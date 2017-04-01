// Modal handler
// http://www.jqueryscript.net/lightbox/Super-Simple-Modal-Popups-with-jQuery-CSS3-Transitions.html
$(function(){
var modalWidth = 960;
var appendthis =  ("<div class='modal-overlay js-modal-close'></div>");

  $(document).on("click","*[data-modal-id]",function(e) {
	  e.preventDefault();
    $("body").append(appendthis);
    $(".modal-overlay").fadeTo(500, 0.7);
    var modalBox = $(this).attr('data-modal-id');
    modalWidth = $('#'+modalBox).outerWidth();
    $('.modal-box').css('max-height', $(window).height() * 0.9);
    $('#'+modalBox).fadeIn($(this).data());
	  $(window).trigger('resize',[modalWidth]);
  });
  
$(document).on("click",".js-modal-close, .modal-overlay",function() {
  $(".modal-box, .modal-overlay").fadeOut(500, function() {
    $(".modal-overlay").remove();
  });
});
 
$(window).resize(function(event,modalWidth) {
  $(".modal-box").css({
    top: (($(window).height() - $(".modal-box").outerHeight()) / 2),
    left: (($(window).width() - modalWidth) / 2)
  });
});
 
});

function removeOverlay() {
  $(".modal-box, .modal-overlay").fadeOut(500, function() {
    $(".modal-overlay").remove();
  });
}

// JS Handler
var cl = "<img style='width:128px;height:128px;display:block;margin:100px auto 0;' id='cl' src='img/loader.gif' alt='Cargando' />";
var currentPage = null;
var maxprogress = 100;
var actualprogress = 0;
var itv = 0;
// Modify according to multimedia lenght
var cantidadPaginas = 27;
var prefijo = "cont";

$(window).load(function() {
	$("#nav-siguiente").click(navAvanzar);
    $("#nav-anterior").click(navAtras);
    $("#nav-inicio").click(navcontenido);
    $("#otro").click(navAvanzar);
});

function clshow() {
	$("#content").append(cl)
}

function clhide() {
	$("#cl").remove()
}

function doStart1() {
    clhide();
    currentPage = 0;
    goToPage();
}

function goToPage() {
    var paginac = prefijo + currentPage + ".html";
    $("#content").load(paginac, null, function(responseText, statusText, xhr) {
        if (statusText == "success")
            // clhide();
        if (statusText == "error")
            alert("Ha ocurrido un error: " + xhr.status + " - " + xhr.statusText);
    });
    visibilidad();
    porcentaje();
}

function visibilidad() {
    if (currentPage == 0) {
        $("#nav-siguiente").show();
        $("#nav-anterior").hide();
        $("#nav-inicio").hide();
    } else if (currentPage == (cantidadPaginas - 1)) {
        $("#nav-siguiente").hide();
        $("#nav-anterior").show();
        $("#nav-inicio").show();
    } else {
        $("#nav-siguiente").show();
        $("#nav-anterior").show();
        $("#nav-inicio").show();
    }
    if (cantidadPaginas == 1) {
        $("#nav-siguiente").hide();
        $("#nav-anterior").hide();
        $("#nav-inicio").hide();
    }
}

function porcentaje() {
    porcentajenum = (currentPage + 1) * 100 / (cantidadPaginas);
    porcentajenum = Math.floor(porcentajenum);
    if (actualprogress >= maxprogress) {
        // Reference caughted in jQuery
		// clearInterval(itv);
        return;
    }
    var progressnum = document.getElementById("progressnum");
    var indicador = document.getElementById("indicador");
    var a = 140;
    var ancho = porcentajenum * a / 100;
    indicador.style.width = ancho + "px";
    progressnum.innerHTML = (porcentajenum) + " %";
    showcurrentpage();
}

function showcurrentpage() {
    txtcurrpage = currentPage + 1;
    totalpages = cantidadPaginas;
    var numpage = document.getElementById("numpage");
    var cadenanumpage = txtcurrpage + " de " + totalpages;
    numpage.innerHTML = cadenanumpage;
}

function navAtras() {
    clshow();
    currentPage--;
    goToPage();
}

function navAvanzar() {
    clshow();
    currentPage++;
    goToPage();
}

function navcontenido() {
    clshow();
    currentPage = 0;
    goToPage();
}

function getCurrentPage() {
    return currentPage;
}