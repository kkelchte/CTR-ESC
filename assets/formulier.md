---
layout: main
title: Formulier
description: Hier voer je de raadsels in.
---

**Helaas zal het niet mogelijk zijn om vragen via deze weg in te geven.**

**De hoofdvraag en eventueel 2 bonusvragen zal manueel op de laptop ingegeven moeten worden.**


<!-- <script type="text/javascript">
function showRecaptcha(element) {
  Recaptcha.create('6LezXT0UAAAAAHMmWAonT_pmff-XtnlqMKUcvifc', element, {
    theme: 'custom', // you can pick another at https://developers.google.com/recaptcha/docs/customization
    custom_theme_widget: 'recaptcha_widget'
  });
}

function setupRecaptcha() {
  var contactFormHost = 'https://ctr-esc-form.herokuapp.com/',
      form = $('#contact-form'),
      notice = form.find('#notice');

  if (form.length) {
    showRecaptcha('recaptcha_widget');

    form.submit(function(ev){
      ev.preventDefault();

      $.ajax({
        type: 'POST',
        url: contactFormHost + 'send_email',
        data: form.serialize(),
        dataType: 'json',
        success: function(response) {
          switch (response.message) {
            case 'success':
              form.fadeOut(function() {
                form.html('<h4>' + form.data('success') + '</h4>').fadeIn();
              });
              break;

            case 'failure_captcha':
              showRecaptcha('recaptcha_widget');
              notice.text(notice.data('captcha-failed')).fadeIn();
              break;

            case 'failure_email':
              notice.text(notice.data('error')).fadeIn();
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          notice.text(notice.data('error')).fadeIn();
        }
      });
    });
  }
}
</script>

<form id="contact-form" class="contact-form" method="post" data-success="Message successfully sent!">

  <label for="name">Name</label>
  <input id="name" type="text" name="name" class="field" required autofocus /><br/>

  <label for="message">Message</label>
  <textarea id="message" name="message" required ></textarea><br/>

  <label for="recaptcha_response_field">Captcha</label> -->
  
  <!-- <div class="g-recaptcha" data-sitekey="6LezXT0UAAAAAHMmWAonT_pmff-XtnlqMKUcvifc"></div>
  
  <div id="recaptcha_widget" class="recaptcha">
    <div class="image">
      <div id="recaptcha_image"></div>
    </div>

    <div class="headline recaptcha_only_if_image">Enter the words above:</div>
    <div class="headline recaptcha_only_if_audio">Enter the numbers you hear:</div> -->

<!--     <input type="text" id="recaptcha_response_field" name="recaptcha_response_field" required />

    <span class="recaptcha_icon"><a href="javascript:Recaptcha.reload()"><i class="fa fa-refresh"></i></a></span>
    <span class="recaptcha_icon recaptcha_only_if_image"><a href="javascript:Recaptcha.switch_type('audio')"><i class="fa fa-volume-up"></i></a></span>
    <span class="recaptcha_icon recaptcha_only_if_audio"><a href="javascript:Recaptcha.switch_type('image')"><i class="fa fa-font"></i></a></span>
    <span class="recaptcha_icon"><a href="javascript:Recaptcha.showhelp()"><i class="fa fa-question-circle"></i></a></span>
  </div><br/>
  <div id="notice" class="notice" data-captcha-failed="Incorrect captcha!" data-error="There was an error sending the message, please try again."></div>
  <button type="submit">Send</button>
</form>

<script type="text/javascript" src="http://www.google.com/recaptcha/api/js/recaptcha_ajax.js"></script>


 -->