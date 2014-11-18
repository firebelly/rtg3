var Main = (function ($) {
	return {
    cartInit: function () {
      // add to cart links
      $('.cart-form').on('ajax:success', function(e, data) {
        $('#cart').html(data);
        var cart_count = $('#cart').find('li').length;
        Main.setCartCount(cart_count);
        Main.showCart();
      });
      // delete cart item links
      $('#cart').on('ajax:success', '.cart-delete', function(e, data) {
        $(this).closest('li').slideUp();
        Main.setCartCount(data);
      });
      // initial cart count (maybe only call this if cookie is set, which is stored when adding to cart?)
      $.get('/cart/count', function(data) {
        Main.setCartCount(data);
      });
    },
    showCart: function() {
      $('#cart').addClass('active');
    },
    setCartCount: function(cart_count) {
      $('.cart-item-count').text(cart_count);
      $('.cart-item-count').toggleClass('active', cart_count > 0);
    },

		mainNav: function () {
      $('.menu-toggle').on('click', function() {
        $(this).toggleClass('menu-open');
        $('.menu').toggleClass('active');
      });
		},
    stickyHeader: function () {
      // Set header height for offset
      var headerH = $('.header_main').outerHeight();
      $(window).resize(function () {
        var headerH = $('.header_main').outerHeight();
      });
      $('.header_main').waypoint(function() {        
        $(this).toggleClass('sticky');
      }, { offset: -headerH });
    },
    smoothScrolling: function () {
      // Set header height for offset
      var headerH = $('.header_main').outerHeight();
      $(window).resize(function () {
        var headerH = $('.header_main').outerHeight();
      });
      smoothScroll.init({
        speed: 500,
        easing: 'easeInOutCubic',
        updateURL: false,
        offset: headerH,
      });
    },
    featureSlider: function () {
      $('.feature-slider').slick({
        autoplay: true,
        autoplaySpeed: 5000
      });

      // Animate the first slide's progress bar. The rest is handled with CSS baby!
      $('.slick-active .progress-bar .bar').hide().delay(500).animate({width:'toggle'}, 1500, 'easeInOutCubic');
      $('.banner-content.feature .progress-bar .bar').hide().delay(500).animate({width:'toggle'}, 1500, 'easeInOutCubic');
    },
    affiliatesSlider: function () {
      $('.affiliates-slider-w2').slick({
          autoplay: true,
          arrows: false,
          slidesToShow: 2
      });
      $('.affiliates-slider-w3').slick({
          autoplay: true,
          arrows: false,
          slidesToShow: 3,
          responsive: [
            {
              breakpoint: 600,
              settings: {
                slidesToShow: 2,
                slidesToScroll: 2
              }
            }
          ]
      });
    },
    reasonsSlider: function () {
      if ($(window).width() > 600 ) {
        $('.reasons-slider').slick({
          autoplay: true,
          slidesToShow: 3
        });
      } else {
        $('.reasons-slider').unslick();
      }

      $(window).resize(function () {
        if ($(window).width() > 600 ) {
          $('.reasons-slider').slick({
            autoplay: true,
            slidesToShow: 3
          });
        } else {
          $('.reasons-slider').unslick();
        }
      });
    },
    blockSliders: function() {
      $('.block-image-slider0').slick({
        adaptiveHeight: true
      });

      $('.block-image-slider1').slick({
        arrows: false,
        draggable: false,
        adaptiveHeight: true,
      });

      $('.block-image-slider2').slick({
        arrows: false,
        draggable: false,
        adaptiveHeight: true,
      });

      $('.block-content-slider1').slick({
        dots: true,
        draggable: false,
        asNavFor: '.block-image-slider1'
      });

      $('.block-content-slider2').slick({
        dots: true,
        draggable: false,
        asNavFor: '.block-image-slider2'
      });

      function nextSlideTitle() {
        $('.block-content-flexslider').each(function() {
          nextTitle = $(this).find('.flex-active-slide').next().find('h3').text();
          $('.block-content-flexslider .flex-next').text(nextTitle);
        });
      }
    },
    formFunctions: function () {
      // only allow digits in money inputs
      $('input[type="number"], input[type="tel"]').numeric({allow: '.'});
      $('form').validate();
    },
    radialProgress: function () {
      var clamp = function (n, min, max) {
        return Math.max(min, Math.min(max, n));
      };

      var drawProgress = function(percent){

        if(isNaN(percent)) {
          return;
        }

        percent = clamp(parseFloat(percent), 0, 1);

        // 360 loops back to 0, so keep it within 0 to < 360
        var angle = clamp(percent * 360, 0, 359.99999);
        var paddedRadius = 50 + 1;
        var radians = (angle * Math.PI / 180);
        var x = Math.sin(radians) * paddedRadius;
        var y = Math.cos(radians) * - paddedRadius;
        var mid = (angle > 180) ? 1 : 0;
        var pathData = 'M 0 0 v -%@ A %@ %@ 1 '.replace(/%@/gi, paddedRadius)
            + mid + ' 1 '
            + x + ' '
            + y + ' z';

        var bar = document.getElementsByClassName ('progress-radial-bar')[0]; 
        bar.setAttribute( 'd', pathData );
      };

      var max = 0.95;
      var progress = 0.0;

      // Set Progress with waypoints
      $('.progress-container').waypoint(function() {
        drawProgress(progress);

        var interval = window.setInterval(function () {
          progress = progress + 0.01;
          if(progress >= max) {
            window.clearInterval(interval);
          }
          drawProgress(progress);
        }, 10);        
      }, { offset: '50%', triggerOnce: true });
    },
    accordians: function () {
      // Set header height for offset
      var headerH = $('.header_main').outerHeight();
      $(window).resize(function () {
        var headerH = $('.header_main').outerHeight();
      });

      $('.accordian-trigger').on('click', function () {
        $('html,body').animate({scrollTop: $(this).offset().top - headerH}, 500, 'easeInOutCubic');

        var tP = $(this).closest('.accordian');
        $('.accordian.active').not(tP).removeClass('active');
        tP.toggleClass('active');
      });
    },
    panes: function () {
      $('.pane-advance').on('click', function(e) {
        e.preventDefault();
        $(this).closest('.pane').removeClass('active').addClass('inactive');
        $(this).closest('.pane').next('.pane').removeClass('inactive').addClass('active');
      });
      $('.pane-devance').on('click', function(e) {
        e.preventDefault();
        $(this).closest('.pane').removeClass('active').addClass('inactive');
        $(this).closest('.pane').prev('.pane').removeClass('inactive').addClass('active');
      });
    },
    video: function () {
      $('.video-toggle').on('click', function (e) {
        e.preventDefault();
        $('.feature-video').toggleClass('active');
      });
      $('.feature-video-background').on('click', function () {
        $('.feature-video.active').removeClass('active');
      });
    },
		initMain: function () {
			$(document).ready(function () {
        Main.cartInit();
				Main.mainNav();
        Main.stickyHeader();
        Main.smoothScrolling();
        Main.featureSlider();
        Main.affiliatesSlider();
        Main.reasonsSlider();
        Main.blockSliders();
        Main.formFunctions();
        Main.radialProgress();
        Main.accordians();
        Main.panes();
        Main.video();
			})
		}
	};
// Pass in jQuery.
})(jQuery);

Main.initMain();