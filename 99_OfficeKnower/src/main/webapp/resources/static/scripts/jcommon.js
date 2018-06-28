var DOMAIN_MINLEN = 2;
var GROUP_MINLEN = 6;

// prototype addMethods -> jQueryj.fn.extend
jQuery.fn.extend({
	toCenter : function()
	{
		this.css("position","absolute");
		this.css("top", Math.max(0, ((jQuery(window).height() - jQuery(this).outerHeight()) / 2) + jQuery(window).scrollTop()) + "px");
		this.css("left", Math.max(0, ((jQuery(window).width() - jQuery(this).outerWidth()) / 2) + jQuery(window).scrollLeft()) + "px");

		return this;
	}

	,openLayer : function()
	{
		this.show();
		this.toCenter();

		return this;
	}

	,closeLayer : function()
	{
		this.hide();
		return this;
	}

	,showPopup : function()
	{
		if( this.length ){
			this.css({'marginLeft': this.outerWidth() / 2 * -1});
			this.css({'marginTop': this.outerHeight() / 2 * -1});
			jQuery('#dimmed').show();
			this.insertAfter(jQuery("#wrap"));
			this.show();

			return this;
		}
	}

	,hidePopup : function(pFlag)
	{
		if( this.length ){
			jQuery('#dimmed').hide();
			this.hide();
			if(pFlag == undefined) this.remove();

			return this;
		}
	}

	,putCursorAtEnd : function() {
		return this.each(function() {

			// Cache references
			var $el = jQuery(this),
			el = this;

			// Only focus if input isn't already
			if (!$el.is(":focus")) {
				$el.focus();
			}

			// If this function exists... (IE 9+)
			if ($el.val() !== "" && el.setSelectionRange) {
			//if (el.setSelectionRange) {

				// Double the length because Opera is inconsistent about whether a carriage return is one character or two.
				var len = $el.val().length * 2;

				// Timeout seems to be required for Blink
				setTimeout(function() {
					el.setSelectionRange(len, len);
				}, 1);

			} else {

			// As a fallback, replace the contents with itself
			// Doesn't work in Chrome, but Chrome supports setSelectionRange
				$el.val($el.val());

			}

			// Scroll to the bottom, in case we're in a tall textarea
			// (Necessary for Firefox and Chrome)
			this.scrollTop = 999999;
		});
	}
});

