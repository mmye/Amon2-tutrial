if(typeof(window.console) == "undefined") { console = {}; console.log = console.warn = console.error = function(a) {}; }
var mdwBtn 	   = $('.modalBtn'), //modal window open button
    overlayOpacity = 0.7, //background opacity
    fadeTime       = 500;
console.log(mdwBtn);

//caution: modal window fails if: mdwBtn.on('click', function(e){...
//it success if it goes like below:
$(document).on('click', '.modalBtn', function (e) {
  console.log('.modalBtn clicked');
  e.preventDefault();
  var setMdw      = $(this),
      setHref     = setMdw.attr('tr'),
      //setSource   = 'Hello, modal window',
      setSource   = $(setHref).html(),
      wdHeight    = $(window).height(); //window height
  $('body').prepend('<div id="mdOverlay"></><div id="mdWindow"><div class="mdClose">x</div><div id="contWrap">' + setSource + '</div></div>');

  $('#mdOverlay, #mdWindow').css({display:'block' , opacity:'0' });
  $('#mdOverlay').css({height:wdHeight}).stop().animate({opacity: overlayOpacity}, fadeTime);
  $('#mdWindow').stop().animate({opacity:'1'}, fadeTime);

  $(window).on('resize', function() {
    console.log('resized@modalwindow.js');
    var adjHeight = $(window).height();
    $('#mdOverlay').css({height:adjHeight});
  });

  $('#mdOverlay, .mdClose').on('click', function() {
    $('#mdWindow, #mdOverlay').stop().animate({opacity:'0'}, fadeTime, function(){
    $('#mdOverlay, #mdWindow').remove();
    });
  });
});

