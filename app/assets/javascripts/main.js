var RTG = (function ($) {
  var headerH,
      youtubePlayer;

  function _init() {
    _resize(); // init vars like headerH
    _cartInit();
    _mainNav();
    _stickyHeader();
    _smoothScrolling();
    _featureSlider();
    _affiliatesSlider();
    _reasonsSlider();
    _blockSliders();
    _formFunctions();
    _radialProgress();
    _accordians();
    _panes();
    _video();
    _tweetIt();

    // About Us page
    if ($('#about-us-page').length>0) {
      _googleMap();
    }
  };

  function _resize() {
    // Set header height for offset
    headerH = $('.header_main').outerHeight();
  };

  function _cartInit() {
    // add to cart links
    $('.cart-form').on('ajax:success', function(e, data) {
      $('.cart-items-wrap').html(data);
      var cartCount = $('#cart').find('li').length;
      _setCartCount(cartCount);
      _showCart();
    });
    // delete cart item links
    $('#cart').on('ajax:success', '.item-remove', function(e, data) {
      e.preventDefault();
      var thisItem = $(this).closest('li.cart-item');
      thisItem.addClass('-removed');
      setTimeout(function () {
        thisItem.velocity(
          { 
            height: 0
          },
          {
            duration: 150
          }
        );
      }, 250);
      setTimeout(function () {
        thisItem.remove();
      }, 400);
      _setCartCount(data);
    });
    // initial cart count (maybe only call this if cookie is set, which is stored when adding to cart? this would allow full caching of page)
    // $.get('/cart/count', function(data) {
    //   _setCartCount(data);
    // });
    $('.cart-toggle').on('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      _showCart();
    });
    // hide cart when clicking on body and (X) buttons
    $('html').on('click', '.body-wrap.unfocus', _hideCart);
    $('.cart-close').on('click', _hideCart);

    // Form input formatting
    $('.cc-num').payment('formatCardNumber');
    $('.cc-exp').payment('formatCardExpiry');
    $('.cc-cvc').payment('formatCardCVC');
    $('.cc-zip').payment('restrictNumeric');
  };

  function _showCart() {
    $('.menu.active').removeClass('active');
    $('.menu-toggle').removeClass('menu-open');
    $('.cart').toggleClass('active cart-stage');
    $('.body-wrap').toggleClass('unfocus');
    $('.cart-review').addClass('active-stage');
  };

  function _setCartCount(cartCount) {
    $('.cart-item-count').text(cartCount);
    $('.cart-item-count').toggleClass('active', cartCount > 0);
    if (cartCount==0) {
      var emptyCartTxt = $('<p>Your cart is currently empty</p>').hide().appendTo('.cart-items-wrap');
      setTimeout(function() {emptyCartTxt.fadeIn()}, 250);
    }
  };

  function _hideCart() {
    $('.body-wrap').removeClass('unfocus');
    $('.stage-submit').removeClass('stage-edit');
    $('.cart').removeClass('active checkout-stage payment-stage');
    $('.cart-stage').removeClass('active-stage');
    $('.cart-review .stage-submit').text('Checkout');
    $('.cart-checkout .stage-submit').text('Payment');       
  };

  // // Toggle the checkout stage
  // $('.checkout-toggle').on('click', function (e) {
  //   e.preventDefault();
  //   if ($(this).hasClass('stage-edit')) {
  //     $('.cart').removeClass('checkout-stage payment-stage');
  //     $('.stage-submit').not(this).removeClass('stage-edit');
  //     $('.cart-checkout .stage-submit').text('Payment');
  //   } else {
  //     $('.cart').removeClass('payment-stage').toggleClass('checkout-stage');          
  //   }
  // });

  // // Toggle the payment stage
  // $('.payment-toggle').on('click', function (e) {
  //   e.preventDefault();
  //   $('.cart').toggleClass('checkout-stage').toggleClass('payment-stage');
  // });

  // // Change unactive stages buttons' text to "Edit", change next stage to active, reverse
  // $('.stage-submit').each(function () {
  //   var originalText;
  //   $(this).on('click', function (e) {
  //     e.preventDefault();
  //     thisStage = $(this).closest('.cart-stage');
  //     nextStage = thisStage.next('.cart-stage');
  //     thisStage.toggleClass('active-stage');
  //     if ($(this).hasClass('stage-edit')) {
  //       $('.cart-stage').not(thisStage).removeClass('active-stage');
  //       $(this).text(originalText).removeClass('stage-edit');
  //     } else if(!$(this).hasClass('stage-edit')) {
  //       originalText = $(this).text();
  //       $(this).text('Edit').addClass('stage-edit');
  //       nextStage.toggleClass('active-stage');
  //     }
  //   });
  // });



  function _mainNav() {
    $('.menu-toggle').on('click', function() {
      $(this).toggleClass('menu-open');
      $('.menu').toggleClass('active');
    });
  };

  function _stickyHeader() {
    $('.header_main').waypoint(function() {        
      $(this).toggleClass('sticky');
    }, { offset: -headerH });
  };

  function _smoothScrolling() {
    smoothScroll.init({
      speed: 500,
      easing: 'easeOutCubic',
      updateURL: false,
      offset: headerH,
    });
  };

  function _featureSlider() {
    $('.feature-slider').slick({
      autoplay: true,
      autoplaySpeed: 5000
    }); 

    // Animate the first slide's progress bar. The rest is handled with CSS baby!
    $('.slick-active .progress-bar .bar').hide().delay(500).animate({width:'toggle'}, 1500, 'easeInOutCubic');
    $('.banner-content.feature .progress-bar .bar').hide().delay(500).animate({width:'toggle'}, 1500, 'easeInOutCubic');
  };

  function _affiliatesSlider() {
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
  };

  function _reasonsSlider() {
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
  };

  function _blockSliders() {
    $('.block-image-slider-static').slick({
      arrows: false,
      autoplay: true,
    });

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

    // ?? not sure what this is
    function nextSlideTitle() {
      $('.block-content-flexslider').each(function() {
        nextTitle = $(this).find('.flex-active-slide').next().find('h3').text();
        $('.block-content-flexslider .flex-next').text(nextTitle);
      });
    }
  };

  function _formFunctions() {
    // only allow digits in money inputs
    $('input[type="number"], input[type="tel"]').numeric({allow: '.'});
    $('form').validate();
  };

  function _radialProgress() {
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
  };

  function _accordians() {
    $('.accordian-trigger').on('click', function () {
      $('html,body').animate({scrollTop: $(this).offset().top - headerH}, 500, 'easeInOutCubic');

      var tP = $(this).closest('.accordian');
      $('.accordian.active').not(tP).removeClass('active');
      tP.toggleClass('active');
    });
  };

  function _panes() {
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
  };

  function _initVideo() {
    youtubePlayer = new YT.Player('video', {
      events: {
        'onReady': RTG.onPlayerReady
      }
    });
  };

  function _onPlayerReady() {
    $('.video-toggle').on("click", function() {
      // wait for video to drop in
      setTimeout(function() {
        youtubePlayer.playVideo();
      }, 250);
    });
    
    $('.feature-video-background').on("click", function() {
      youtubePlayer.pauseVideo();
    });
  };

  function _video() {
    $('.video-toggle').on('click', function (e) {
      e.preventDefault();
      $('.feature-video').velocity(
        { 
          opacity: 1
        },
        { 
          display: "block" 
        }
      );
      $('.video-wrap').velocity(
        { 
          top: '50%'
        },
        {
          delay: 50,
          easing: "easeOut"
        }
      );
    });
    $('.feature-video-background').on('click', function () {
      $('.feature-video').velocity(
        { 
          opacity: 0
        },
        { 
          display: "none",
          delay: 100
        }
      );
      $('.video-wrap').velocity('reverse');
    });

    // Fitvids to the rescue!
    $('.video-wrap').fitVids();
  };

  function _googleMap() {
    var map;
    var MY_MAPTYPE_ID = 'custom_style';
    var firebelly = new google.maps.LatLng(41.900866,-87.694542);

    function initialize() {

      var styles = [
        {
          "featureType": "landscape.man_made",
          "stylers": [
            { "visibility": "off" }
          ]
        },{
          "featureType": "landscape.natural",
          "stylers": [
            { "color": "#E54C97" }
          ]
        },{
          "featureType": "road.arterial",
          "elementType": "geometry.fill",
          "stylers": [
            { "color": "#E54C97" }
          ]
        },{
          "featureType": "road.arterial",
          "elementType": "labels.text",
          "stylers": [
            { "color": "#ffffff" }
          ]
        },{
          "featureType": "road.local",
          "elementType": "geometry.fill",
          "stylers": [
            { "color": "#E54C97" }
          ]
        },{
          "featureType": "road.local",
          "elementType": "labels.text",
          "stylers": [
            { "color": "#ffffff" }
          ]
        },{
          "featureType": "road.arterial",
          "elementType": "geometry.stroke",
          "stylers": [
            { "color": "#ffffff" },
            { "weight": 1 }
          ]
        },{
          "featureType": "road.local",
          "elementType": "geometry.stroke",
          "stylers": [
            { "color": "#ffffff" },
            { "weight": 1 }
          ]
        },{
          "featureType": "road.arterial",
          "elementType": "labels.text",
          "stylers": [
            { "visibility": "simplified" }
          ]
        },{
          "featureType": "road.local",
          "elementType": "labels",
          "stylers": [
            { "visibility": "simplified" }
          ]
        },{
          "featureType": "road.highway",
          "elementType": "labels.text",
          "stylers": [
            { "visibility": "simplified" }
          ]
        },{
          "featureType": "road.highway",
          "elementType": "labels.text",
          "stylers": [
            { "color": "#ffffff" }
          ]
        },{
          "featureType": "road.highway",
          "elementType": "geometry.fill",
          "stylers": [
            { "color": "#E54C97" }
          ]
        },{
          "featureType": "road.highway",
          "elementType": "geometry.stroke",
          "stylers": [
            { "color": "#ffffff" }
          ]
        },{
          "featureType": "poi.business",
          "stylers": [
            { "visibility": "off" }
          ]
        },{
          "featureType": "poi.medical",
          "stylers": [
            { "visibility": "off" }
          ]
        },{
          "featureType": "poi.school",
          "stylers": [
            { "visibility": "off" }
          ]
        },{
          "featureType": "poi.place_of_worship",
          "stylers": [
            { "visibility": "off" }
          ]
        },{
          "featureType": "transit.station.bus",
          "stylers": [
            { "visibility": "off" }
          ]
        },{
          "featureType": "poi.park",
          "elementType": "geometry.fill",
          "stylers": [
            { "color": "#ffffff" },
            { "visibility": "on" }
          ]
        },{
          "featureType": "poi.park",
          "elementType": "labels",
          "stylers": [
            { "visibility": "off" }
          ]
        },{
          "featureType": "administrative",
          "elementType": "all",
          "stylers": [
            { "visibility": "simplified" }
          ]
        },{
          "featureType": "administrative",
          "elementType": "labels",
          "stylers": [
            { "color": "#ffffff" }
          ]
        },{
          "featureType": "water",
          "elementType": "all",
          "stylers": [
            { "visibility": "simplified" },
            { "color": "#E54C97"}
          ]
        },{
          "featureType": "transit.station.rail",
          "elementType": "all",
          "stylers": [
            { "visibility": "off" }
          ]
        }
      ]

      // Test for touch and disable if true
      if (Modernizr.touch) {   
          var dragstate = false
      } else {   
          var dragstate = true
      } 

      var mapOptions = {
        zoom: 17,
        center: firebelly,
        disableDefaultUI: true,
        draggable: dragstate,
        mapTypeControlOptions: {
          mapTypeIds: [google.maps.MapTypeId.ROADMAP, MY_MAPTYPE_ID]
        },
        mapTypeId: MY_MAPTYPE_ID
      }
      var map = new google.maps.Map(document.getElementById('map'), mapOptions);

      google.maps.event.addDomListener(window, 'resize', function() {
          map.setCenter(firebelly);
      });

      var image = {
        url: '/assets/marker.svg'
      };
      var link = 'https://www.google.com/maps/place/Reason+to+Give/@41.900868,-87.694523,15z/data=!4m2!3m1!1s0x0:0xee5c8496d8160eec?sa=X&ei=SS9mVMn4JMSfyATb44DYBQ&ved=0CHEQ_BIwDQ'
      var marker = new google.maps.Marker({
          position: firebelly,
          map: map,
          animation: google.maps.Animation.DROP,
          title: 'Firebelly Design',
          icon: image,
          url: link
      });

      var styledMapOptions = {
          name: 'Custom Style'
        };

      var customMapType = new google.maps.StyledMapType(styles, styledMapOptions);

      map.mapTypes.set(MY_MAPTYPE_ID, customMapType);

      google.maps.event.addListener(marker, 'click', function() {
          window.location.href = this.url;
      });
    }

    google.maps.event.addDomListener(window, 'load', initialize);
  };

  function _tweetIt() {
    window.twttr=(function(d,s,id){var t,js,fjs=d.getElementsByTagName(s)[0];if(d.getElementById(id)){return}js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);return window.twttr||(t={_e:[],ready:function(f){t._e.push(f)}})}(document,"script","twitter-wjs"));

    function popitup(url, title, w, h) {
      var left = (screen.width/2)-(500/2);
      var top = (screen.height/2)-(200/2);
      newwindow=window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=500, height=240, top='+top+', left='+left);
      if (window.focus) {newwindow.focus()}
      return false;
    }

    $('.tweet-it').on('click', function (e) {
      e.preventDefault();
      var turl = $(this).attr('href');
      popitup(turl);
    });
  };

  // public functions
  return {
      init: _init,
      resize: _resize,
      showCart: _showCart,
      hideCart: _hideCart,
      initVideo: _initVideo,
      onPlayerReady: _onPlayerReady
  };

})(jQuery);


// fire up the mothership
$(document).ready(RTG.init);
// zig-zag the mothership
$(window).resize(RTG.resize);

// this function gets called when YouTube API is ready to use
function onYouTubePlayerAPIReady() {
  RTG.initVideo();
}

// Inject YouTube API script
var tag = document.createElement('script');
tag.src = "//www.youtube.com/player_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
