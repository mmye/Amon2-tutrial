//slider
$(document).ready(function (){

  //map links to certain elements to trigger changing slides
  $('#header ul li a').on('click', function (){
    var integer = $(this).attr('rel');

    //Define parent element to slide
    $('#tabArea').animate({left:-960*(pargeInt(integer)-1)})

    $('#header ul li a').each(function(){
    $(this).removeClass('active');
      if($(this).hasClass('button'+integer)){
        $(this).addClass('active')}
    });
  });
});
