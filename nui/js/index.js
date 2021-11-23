$( document ).ready(function() {


$( "#submit" ).click(function() {
  $.post(`https://${GetParentResourceName()}/gewinne`, JSON.stringify({}));
});


$("body").hide();
document.onkeyup = function(data) {
  if (data.which == 27) {
    $("body").hide();
    $.post(`https://${GetParentResourceName()}/cursor`, JSON.stringify({}));
  }
};
  window.addEventListener('message', function(event) {

    if (event.data.action == 'close') {
      $("body").hide();

    }
    if (event.data.action == 'open') {
      $("body").show();
    
	}
});

var message = "";
var date = new Date();
var day = date.getDate();
var month = date.getMonth() + 1;
var scrolled = false;
var timeDelay = 500;

var cardReveal = function() {

}  
  
if(month === 12) {
  $("li").each( function( index ) {
    var adventwindow = index + 1;
    var item = $(this);

    if( day !== adventwindow && adventwindow < day ) {
      window.setTimeout(function(){
        item.children(".door").addClass("open");
      }, timeDelay);
    }

    timeDelay += 100;



    if( adventwindow <= day ) {
    }

    if(adventwindow === day) {
      $(this).addClass("current");
      $(this).addClass("jiggle");
    }

    $(this).on("click", function() {
      if(adventwindow === day) {
        $("body").hide();
        $.post(`https://${GetParentResourceName()}/cursor`, JSON.stringify({}));
        $.post(`https://${GetParentResourceName()}/openday`, JSON.stringify({}));

      }
      if(adventwindow <= day) { 

        if ($(this).children(".door").hasClass('open')) {


        } else {
          $(this).children(".door").toggleClass("open");
        }
      

        $(this).removeClass("jiggle");

      }
    });

  });

}
      

});