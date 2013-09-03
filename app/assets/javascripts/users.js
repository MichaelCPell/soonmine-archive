$(document).ready(function(){

  $("#sort-show").click(function(e){
    e.preventDefault();
    $("#sort-contents").slideToggle("slow");
  });

  $(".product-name").shorten({showChars: 23});

  // $(".morelink").on('click', function() {

  // 	$(this).closest('.block-product-info').animate({height: "90px"}, 300);
  
  // });


  // $(document).on("click", ".less", function() { 

  // 	$(this).closest('.block-product-info').animate({height: "60px"}, 300);

  // }); 

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


});