/* global $, Stripe */

// Document ready.
$(document).on('turbolinks:load', function(){ 
  var theForm = $('#pro_form');
  var submitBtn = $('#form-submit-btn');
 
  // Set Stripe public key.
  Stripe.setPublishableKey( $('meta["stripe-key"]').attr('content') );
  
  // When user clicks form submit btn.
  submitBtn.click(function(event) {
    // Prevent default submission behavior.

    event.preventDefault
    
    // Collect credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month'),
        expYear = $('#card_year');
  
    // Send card info to Stripe.
    Stripe.createToken({
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_year: expYear
    }, stripeResponseHandler);
  });
  
  // Stripe will return card token.
  
  // Inject card token as hidden field into form.
  // Submit form to Rails app.
});