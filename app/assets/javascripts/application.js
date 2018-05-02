// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).on 'ajax:success', 'a.vote', (status,data,xhr)->
  # update counter
  $(".votes-count[data-id=#{data.id}]").text data.count

  # toggle links
  $("a.vote[data-id=#{data.id}]").each ->
    $a = $(this)
    href = $a.attr 'href'
    text = $a.text()
    $a.text($a.data('toggle-text')).attr 'href', $a.data('toggle-href')
    $a.data('toggle-text', text).data 'toggle-href', href
    return

  return