(function() {
  $(function() {
    var interactions;
    interactions = function() {
      $('.popup.input [type="text"]').on('keydown', function(e) {
        var label, links, nextIndex, nextLabel, nextPopup, parent, parentID;
        if (e.keyCode === 13 || e.keyCode === 27) {
          return $('.popup:visible, .hide-popup').fadeOut();
        } else if (e.keyCode === 9) {
          e.preventDefault();
          parent = $('.popup:visible');
          parentID = parent.attr('id');
          label = $("[href*='#open-" + parentID + "']");
          links = $('.quote-form p a:visible');
          nextIndex = $('.quote-form p a:visible').index(label);
          nextLabel = links.eq(nextIndex + 1);
          nextPopup = $(nextLabel.attr('href').replace('open-', ''));
          $('.popup:visible, .hide-popup').fadeOut();
          nextLabel.click();
          return nextPopup.find('input').focus();
        }
      });
      $('.quote .popup, .show-cpl, .quote .hide-popup').hide();
      $('.popup.input input').forceNumericOnly();
      $("[href*='#open-']").on('click', function(e) {
        var formOffset, offsetLeft, offsetTop, popup, quoteHeight, quoteOffset, quoteRowMargin;
        e.preventDefault();
        $('.hide-popup').show();
        $('.popup:visible').fadeOut();
        formOffset = $('.quote-form').offset();
        quoteOffset = $('.quote.partial').offset().top;
        quoteHeight = $('.quote.partial').height() + 120;
        offsetTop = $(this).offset().top - formOffset.top - 140;
        quoteRowMargin = $('#quote-row').offset().left;
        offsetLeft = $(this).offset().left - quoteRowMargin;
        popup = $($(this).attr('href').replace('open-', ''));
        popup.css({
          top: offsetTop,
          left: offsetLeft
        });
        popup.fadeIn().find('input').focus();
        return $('.hide-popup').css({
          top: quoteOffset,
          height: quoteHeight
        });
      });
      $('.popup button, .popup label').on('click', function(e) {
        var parent;
        if ($(this).is('button')) {
          e.preventDefault();
        } else {
          $(this).prev('input').prop('checked', 'checked');
        }
        parent = $('.popup:visible');
        parent.fadeOut();
        return $('.hide-popup').hide();
      });
      $('.hide-popup').on('click', function() {
        $('.popup:visible').fadeOut();
        return $(this).hide();
      });
      $('.leavemynumber').hide();
      return $('[href="#leavenumber"]').on('click', function(e) {
        e.preventDefault();
        return $('.leavemynumber').slideDown();
      });
    };
    return interactions();
  });

  $.fn.isOnScreen = function() {
    var bounds, onscreen, viewport, win;
    win = $(window);
    viewport = {
      top: win.scrollTop(),
      left: win.scrollLeft()
    };
    viewport.right = viewport.left + win.width();
    viewport.bottom = viewport.top + win.height();
    bounds = this.offset();
    bounds.right = bounds.left + this.outerWidth();
    bounds.bottom = bounds.top + this.outerHeight();
    onscreen = viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom;
    return !onscreen;
  };

  $.fn.forceNumericOnly = function() {
    return this.each(function() {
      return $(this).keydown(function(e) {
        var key;
        key = e.charCode || e.keyCode || 0;
        return key === 8 || key === 9 || key === 13 || key === 46 || key === 110 || key === 190 || (key >= 35 && key <= 40) || (key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key === 65 && e.ctrlKey === true);
      });
    });
  };

}).call(this);
