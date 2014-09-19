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
      var planPrice = subscriptionPlan.price_cents / 100,
          periodStart = moment(),
          periodEnd   = moment().add(subscriptionPlan.interval_count, subscriptionPlan.interval);

      if (planPrice === 0) {
        return 'You will not be charged for the life of the selected plan.';
      }

      return 'You will be charged <strong>$' + planPrice.toFixed(2) + '</strong> for ' + periodStart.format('MMM Do, YYYY') + ' &#8211; ' + periodEnd.format('MMM Do, YYYY');
    }

    function setChangeMessage(newPlan) {
      if (currentPlanId === null) {
        if (newPlan.trial_period_days > 0) {
          var trialEnd = moment().add(newPlan.trial_period_days, 'days');
          $('.message').html('<strong>' + newPlan.trial_period_days + ' Day Free Trial</strong><br>The free trial will end on ' + trialEnd.format('MMM Do, YYYY') + '.');
        } else if (newPlan.price_cents === 0) {
          $('.message').html('<strong>You have selected a FREE plan.</strong><br>' + priceMessageForPlan(newPlan) + '.');
        } else {
          $('.message').html('You will be charged immediately for this plan.<br>' + priceMessageForPlan(newPlan) + '.');
        }
        return;
      }

      if (newPlan.id + '' === currentPlanId) {
        $('.message').html(noChangeMessage);
        return;
      }

      if (currentSubscription &&
          currentSubscription.status === "trialing" &&
          newPlan.trial_period_days > 0
      ) {
        var trialEnd = moment(currentSubscription.current_period_start).add(newPlan.trial_period_days, 'days');

        if (moment().isAfter(trialEnd)) {
          $('.message').html('The selected plan\'s free trial is shorter than your current plan\'s trial.<br>' + priceMessageForPlan(newPlan) + '.');
        } else {
          $('.message').html('Your free trial will continue.<br>The free trial will end on ' + trialEnd.format('MMM Do, YYYY'));
        }

        return;
      }

      var currentPriceCentsPerDay = currentPlan.price_cents / currentPeriodDays,
          currentPriceCentsCredit = currentPriceCentsPerDay * currentPeriodDaysLeft,
          creditAmount = currentPriceCentsCredit / 100;

      if (currentPriceCentsCredit > 0) {
        $('.message').html('You will receive a <strong>$' + creditAmount.toFixed(2) + '</strong> credit on your account.<br>' + priceMessageForPlan(newPlan) + '.');
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
      $('.subscription-plan[data-id="' + currentPlan.id + '"]').addClass('current');
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
