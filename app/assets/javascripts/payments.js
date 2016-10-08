$(document).ready(function(){
  var $form = $('#payment-form');

  $form.submit(function(event) {
    event.preventDefault();
    // Disable the submit button to prevent repeated clicks:
    $form.find('input:submit').prop('disabled', true);

    // Request a token from Stripe:
    Stripe.card.createToken($form, stripeResponseHandler);

  });

    stripeResponseHandler = function(status, response) {
      console.log(status);
      console.log(response);

    var $form = $('#payment-form');

    if (response.error) { // Problem!

      // Show the errors on the form:
      $form.find('.payment-errors').text(response.error.message);
      $form.find('.submit').prop('disabled', false); // Re-enable submission

    } else { // Token was created!

      // Get the token ID:
      var token = response.id;

      // Insert the token ID into the form so it gets submitted to the server:
      $("#stripe_token").val(token);
      // $form.append($('<input type="hidden" name="stripeToken">').val(token)); use that above code rather than this one

      // Submit the form:
      // submit the form with the Stripe token to ur Rails server
      $("#server-form").submit();
      // $form.get(0).submit();
    }
  }
});
