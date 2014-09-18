//= require moment

(function() {
  "use strict";

  App.subscriptionPlanSelect = function(currentSubscription, subscriptionPlans) {
    var currentPlanId = null;

    function findSubscriptionPlan(planId) {
      var selectedPlan;

      $.each(subscriptionPlans, function() {
        if (this.id + '' === planId + '') {
          selectedPlan = this;
        }
      });

      return selectedPlan;
    }

    function priceMessageForPlan(subscriptionPlan) {
      var planPrice = (subscriptionPlan.price_cents / 100).toFixed(2),
          periodStart = moment(),
          periodEnd   = moment().add(subscriptionPlan.interval_count, subscriptionPlan.interval);

      return 'You will be charged <strong>$' + planPrice + '</strong> for ' + periodStart.format('MMMM Do') + ' - ' + periodEnd.format('MMMM Do');
    }

    function setChangeMessage(newPlan) {
      if (currentPlanId === null) {
        $('.message').html('You do not have an existing subscription.<br>' + priceMessageForPlan(newPlan) + '.');
        return;
      }

      if (newPlan.id + '' === currentPlanId) {
        $('.message').html(noChangeMessage);
        return;
      }

      var currentPriceCentsPerDay = currentPlan.price_cents / currentPeriodDays,
          currentPriceCentsCredit = currentPriceCentsPerDay * currentPeriodDaysLeft,
          creditAmount = (currentPriceCentsCredit / 100).toFixed(2);

      if (currentPriceCentsCredit > 0) {
        $('.message').html('You will receive a <strong>$' + creditAmount + '</strong> credit on your account.<br>' + priceMessageForPlan(newPlan) + '.');
      } else {
        $('.message').html('&nbsp;<br>' + priceMessageForPlan(newPlan) + '.');
      }
    }

    function setSelectedPlan(subscriptionPlan) {
      $('.subscription-plan').each(function() {
        $(this).removeClass('selected');
      });
      $('.subscription-plan[data-id="' + subscriptionPlan.id + '"]').addClass('selected');
      $('#subscription_subscription_plan_id').val(subscriptionPlan.id);
    }

    function setSubmitButtonDisabled(disabled) {
      if (disabled) {
        $('input[type="submit"]').prop('disabled', 'disabled');
      } else {
        $('input[type="submit"]').prop('disabled', '');
      }
    }

    if (currentSubscription) {
      var currentPeriodStart    = moment(currentSubscription.current_period_start),
          currentPeriodEnd      = moment(currentSubscription.current_period_end),
          currentPeriodDays     = currentPeriodEnd.diff(currentPeriodStart, 'days', true),
          currentPeriodDaysLeft = currentPeriodEnd.diff(moment(), 'days', true),
          currentPlan           = currentSubscription.plan,
          noChangeMessage       = $('.message').html();

      currentPlanId = currentPlan.id + '';

      // Setup elements with current plan selected
      setSelectedPlan(currentPlan);
    } else {
      $('.message').html('You do not have an existing subscription.<br>Select a plan to sign up for a new subscription.')
    }
    setSubmitButtonDisabled(true);

    $('.subscription-plan').click(function() {
      var element = $(this),
          selectedPlanId = element.data('id') + '',
          selectedPlan = findSubscriptionPlan(selectedPlanId);

      // Set the css classes and hidden field value
      setSelectedPlan(selectedPlan);

      // Enable/disable the submit button
      setSubmitButtonDisabled(selectedPlanId === currentPlanId);

      // Set the message for upgrading / downgrading
      setChangeMessage(selectedPlan);

      return false;
    });
  };

})();
