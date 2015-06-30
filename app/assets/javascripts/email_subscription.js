(function() {
  'use strict'
  function EmailSubscriptionForm(form) {
    var $form = $(form);
    var $alerts = $form.find('.alert-box');
    var $input = $form.find('input[type=email]');
    var $submit = $form.find('button');
    var action = $form.attr('action');
    var method = $form.attr('method');

    $form.on('valid.fndtn.abide', function() {
      var email = $form.find('input[type=email]').val();
      $alerts.hide();
      $submit.prop('disabled', true);
      $.ajax({
        url: action,
        dataType: 'json',
        type: method,
        data: {email: email},
        success: function(data) {
          $alerts.filter('.success').show();
          $alerts.filter('.alert').hide();
          $input.remove();
          $submit.remove();
        },
        error: function(jqXHR) {
          var msg = jqXHR.responseJSON.errors[0];
          $submit.removeProp('disabled');
          $alerts.filter('.success').hide();
          $alerts.filter('.alert').show().find('.error-message').text(msg);
        }
      })
    });
  }

  window.EmailSubscriptionForm = EmailSubscriptionForm
}())
