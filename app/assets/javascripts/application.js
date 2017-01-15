// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
    $(window).bind('scroll load', function() {

        $('.card').each( function(i){

            var top_of_object = $(this).position().top;
            var bottom_of_window = $(window).scrollTop() + $(window).height();

            /* Add to bottom of window to start fading slightly before item comes into view*/
            bottom_of_window = bottom_of_window - 50;

            if( bottom_of_window > top_of_object ){
                $(this).addClass('in-view');
            }
        });

        $('.card').each( function(i){

            var top_of_object = $(this).position().top;
            var bottom_of_window = $(window).scrollTop() + $(window).height();

            /* Add to bottom of window to start fading slightly before item comes into view*/
            bottom_of_window = bottom_of_window;

            if( bottom_of_window < top_of_object ){
                $(this).removeClass('in-view');
            }
        });

        $('.animate-in').each( function(i){

            var bottom_of_object = $(this).position().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();

            /* Add to bottom of window to start fading slightly before item comes into view*/
            bottom_of_window = bottom_of_window + 200;

            if( bottom_of_window > bottom_of_object ){
                $(this).addClass('in-view');
            }
        });

        $('.animate-in').each( function(i){

            var top_of_object = $(this).position().top;
            var bottom_of_window = $(window).scrollTop() + $(window).height();

            /* Add to bottom of window to start fading slightly before item comes into view*/
            bottom_of_window = bottom_of_window;

            if( bottom_of_window < top_of_object ){
                $(this).removeClass('in-view');
            }
        });

    });
});
