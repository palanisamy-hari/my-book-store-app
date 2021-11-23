Stripe.setPublishableKey('sk_test_51Jz6w7KqNiU0P5FDnPDZzuDAsJZJ0t2yKCGUEKIOaMEOCH90hJIydXp6JclMNZ4GtQnLGrIkC8UzyVShk3vm8Jts00E8HQ1dRD');

var $form = $('#checkout-form');

$form.submit(function(event){

	$('#payment-error').addClass('hidden');
	$form.find('button').prop('disabled', true);

	Stripe.card.createToken({
		number: $('#card-number').val(),
		cvc: $('#card-cvc').val(),
		exp_month: $('#card-expiry-month').val(),
		exp_year: $('#card-expiry-year').val(),
		name: $('#card-name').val()
	}, stripeResponseHandler);

	return false;
});

function stripeResponseHandler(status, response) {

  if (response.error) { // Problem!

    // Show the errors on the form
    $('#payment-error').text(response.error.message);
    $('#payment-error').removeClass('hidden');
    $form.find('button').prop('disabled', false); // Re-enable submission

  } else { // Token was created!

    // Get the token ID:
    var token = response.id;

    // Insert the token into the form so it gets submitted to the server:
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));

    // Submit the form:
    $form.get(0).submit();

  }
}