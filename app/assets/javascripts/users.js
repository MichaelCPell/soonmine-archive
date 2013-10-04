$(document).ready(function(){

(function () {

  var initialPos = 0;
  var sortButtonWrap = $(".sort-show-wrap");

    sortButtonWrap.click(function(e) {
        e.preventDefault();
        $("#sort-container").animate({ left: initialPos }, 300, 'linear', function() {
          sortButtonWrap.addClass('active');
          if(initialPos == 0) { 
            initialPos = -200; 
          }
          else { 
            sortButtonWrap.removeClass('active');
            initialPos = 0; 
          }
        });
      });

})();  

(function () {

  $('.responsive-sort-menu').on('click', function(e) {
      e.stopPropagation();
      $("#sort-container").slideToggle();
  });

 
     $("#sort-container").on('clickoutside', function() {
            $(this).hide();
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

  $("#sort-container span").click(function(){
    window.location.href = $(this).data('target');
  })

})();

$('img[src="/assets/no_product_image.jpg"]').addClass('no-product-image');

  (function () {

      var responsiveMenu = {

          init: function () {

              var self = this;
              self.toggleMenu();
              self.clickAnywhereToClose();

          },

          toggleMenu: function () {

              var mainMenu = $('.so-main-menu');
              var siteBody = $('body');
              var self = this;

              $('.responsive-nav-btn').on('click', function () {



                  if (mainMenu.hasClass("isOpen")) {
                      mainMenu.animate({
                          right: '-262px',
                      }, {
                          duration: 300,
                          complete: function () {

                              siteBody.removeClass('responsive-menu-active');
                              mainMenu.removeClass('isOpen');

                          }

                      });


                  } else {

                      mainMenu.animate({
                          right: '0px',
                          display: 'block'
                      }, {
                          duration: 300,
                          complete: function () {

                              mainMenu.addClass('isOpen');

                          }

                      });

                      siteBody.addClass('responsive-menu-active');

                  }


              });


          },

          clickAnywhereToClose: function () {



            $(document).on('click', 'html', function() {

              var mainMenu = $('.so-main-menu');
              var siteBody = $('body');
              var positionRight = $('.so-main-menu').css('right');

              mainMenu.on('click', function(e) {
                  e.stopPropagation();
              });

                 if ( positionRight === '0px' ) {

                    mainMenu.animate({
                        right: '-262px',
                    }, {
                        duration: 300,
                        complete: function () {

                            siteBody.removeClass('responsive-menu-active');
                            mainMenu.removeClass('isOpen');

                        }

                    });

                 } else {
                    return
                 }
                    
                    
                   
              });

          

          } 

      }

      responsiveMenu.init();

  })();

});


