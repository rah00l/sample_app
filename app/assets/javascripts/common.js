function showModal(id, width) {
  var el = $('#'+id).first();
  // console.log(el);
  if (el.length === 0 || el.is(':visible')) {return;}
  var title = el.find('h3.title').text();
  el.dialog({
    width: width,
    modal: true,
    resizable: false,
    dialogClass: 'modal',
    title: title
  });
  el.find("input[type=text], input[type=submit]").first().focus();
}

function hideModal(el) {
  var modal;
  if (el) {
    modal = $(el).parents('.ui-dialog-content');
  } else {
    modal = $('#ajax-modal');
  }
  modal.dialog("close");
}

function observeSearchfield(fieldId, targetId, url) {
  $('#'+fieldId).each(function() {
    var $this = $(this);
    $this.addClass('autocomplete');
    $this.attr('data-value-was', $this.val());
    var check = function() {
      var val = $this.val();
      if ($this.attr('data-value-was') != val){
        $this.attr('data-value-was', val);
        $.ajax({
          url: url,
          type: 'get',
          data: {q: $this.val()},
          success: function(data){ if(targetId) $('#'+targetId).html(data); },
          beforeSend: function(){ $this.addClass('ajax-loading'); },
          complete: function(){ $this.removeClass('ajax-loading'); }
        });
      }
    };
    var reset = function() {
      if (timer) {
        clearInterval(timer);
        timer = setInterval(check, 300);
      }
    };
    var timer = setInterval(check, 300);
    $this.bind('keyup click mousemove', reset);
  });
}


 $(function ()
 {
  $('#ajax-modal').keypress(function(e) {
    // alert("-----------?");
      $('#tags_search input').keyup(function () {
      // console.log("---------");
      $.get($('#tags_search').attr('action'), $('#tags_search').serialize(), null, 'script');
      return false;
    });
      if (e.keyCode == $.ui.keyCode.ENTER) {
            //Close dialog and/or submit here...
      }
});
});