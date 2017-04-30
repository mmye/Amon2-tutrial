$(function () {
  var preview = $('#preview');
  preview.css({
    height: $(window).height() - preview.offset().top - 20,
    overflow: 'auto'
  });
    $('textarea').focus().keyup(function () {
    //Cancel html request
    event.preventDefault;

    var text   = $(this).val();
    var format = $('input:radio[name=format]:checked').val();
    $.ajax({
      url: '/preview',
      type: 'POST',
      data: {
        'XSRF-TOKEN': $.cookie('XSRF-TOKEN'), //Workaround for Amon2 XSS measure
        text: text,
        format: format
      },
      success: function (result) {
        console.log(result);
        preview.html(result);

      }
    });
  });
});
