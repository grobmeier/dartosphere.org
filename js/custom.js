$(document).ready(function(){
   $('.bxslider').bxSlider({
   	  mode: 'fade',
   	  controls: false,
   	  auto: true,
   	  autoHover: true,
   	  speed: 1000
   });
});


$(function() {
// TinyNav.js
   $('#menu').tinyNav({
     header: 'Navigation'
   });

});


// jQuery selectors
$('.navigation ul li:last-child').last('last');
