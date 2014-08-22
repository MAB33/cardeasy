// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('ready page:load', function(){

	$(".flashMessages").click(function() {
		$(this).slideUp(500);
	});


	$('.wrapper').hide();
	$('#cardWrapper').show();
	// $(".dropdownTrigger").click(function(){
	//     $(this).siblings('.wrapper').slideToggle(600);
 //  });

	$(".dropdownTrigger").click(function(){
    if ( $(this).siblings('.wrapper').is(":hidden") ) {
    	$(this).next('.fa-plus-circle').css('display', 'none');
      $(this).siblings('.wrapper').slideDown();
    } else {
      $(this).siblings('.wrapper').slideUp();
    }
  });

});