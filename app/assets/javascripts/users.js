var fakeClick = function(path){
  window.location.href = path;
}

$(document).ready(function(){

  $("#sort-show").click(function(e){
    e.preventDefault();
    $("#sort-contents").slideToggle("slow");
  });

  $(".product-name").shorten({showChars: 24});

  $(".block-product-info").hover(
    function(){
      $(this).animate({height: "90px"}, 300);
      $(this).find(".morelink").click();
    },
    function(){
      $(this).animate({height: "60px"}, 300);
      $(this).find(".less").click();
  });
  
  $(window).scroll(function(){
      if ($(this).scrollTop() > 100) {
          $('.scrollup').fadeIn();
      } else {
          $('.scrollup').fadeOut();
      }
  }); 

  $('.scrollup').click(function(){
      $("html, body").animate({ scrollTop: 0 }, 600);
      return false;
  });

  $("#sort-container input").click(function(){
    fakeClick($(this).data('target'))
  })

});


