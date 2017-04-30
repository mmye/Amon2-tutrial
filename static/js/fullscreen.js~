$('body').append('<img src="static/upload/fullscreen.jpg" id="fullScreen">');
console.log('loading fullscreen..');
$(window).load(function(){
  var setFull= $('#fullScreen'),
  fadeSpeed = 500;
  imgRatio = setFull.width() / setFull.height();

  function imgFit(){
  var wdWidth = $(window).width(),
  wdHeight = $(window).height(),
  setHeight = Math.round(wdWidth/imgRatio);

  if(setHeight < wdHeight){
    setHeight = $(window).height();
    wdWidth = Math.round(setHeight * imgRatio);
    }

  setFull.css({marginTop:Math.round(-setHeight / 2),
    marginLeft:Math.round(-wdWidth / 2),
    width:wdWidth,
    height:setHeight});
  }

  $(window).on('resize', function(){imgFit();});
  imgFit();

  setFull.css({visilibity:'visible', opacity:'0'}).
  animate({opacity:'1'}, fadeSpeed);
});
