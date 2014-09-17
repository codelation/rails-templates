(function() {
  "use strict";

  App.subscriptionPlanSelect = function() {
    var currentSubscriptionPlanId = $('#current_subscription_plan_id').val() + '';

    $('.subscription-plan').click(function() {
      var element = $(this),
          subscriptionPlanId = element.data('id') + '';

      // Set the css class on the selected plan
      $('.subscription-plan').each(function() {
        $(this).removeClass('selected');
      });
      element.addClass('selected');

      // Set the hidden field value for the selected plan
      $('#subscription_subscription_plan_id').val(subscriptionPlanId);

      // Disable the update button if the current plan is selected
      if (subscriptionPlanId === currentSubscriptionPlanId) {
        $('input[type="submit"]').prop('disabled', 'disabled');
      } else {
        $('input[type="submit"]').prop('disabled', '');
      }

      return false;
    });

    $('.subscription-plan').each(function() {
      var element = $(this),
          subscriptionPlanId = element.data('id') + '';

      if (subscriptionPlanId === currentSubscriptionPlanId) {
        element.addClass('selected');
      } else {
        element.removeClass('selected');
      }
    });
  };

})();
