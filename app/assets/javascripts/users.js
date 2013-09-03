$(document).ready(function(){

  $("#sort-show").click(function(e){
    e.preventDefault();
    $("#sort-contents").slideToggle("slow");
  });

  $(".product-name").shorten({showChars: 17});

  $(".morelink").on('click', function() {

  	$(this).closest('.block-product-info').animate({height: "90px"}, 300);
  
  });


  $(document).on("click", ".less", function() { 

  	$(this).closest('.block-product-info').animate({height: "60px"}, 300);

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