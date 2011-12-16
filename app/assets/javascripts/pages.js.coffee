# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".hr:last-child").addClass 'last-child'
  
  ###
   * DEFAULT TEXT
   *
   * How to implement:
   *
   * This code makes it so you can have a default text on a
   * text input which vanishes if the user focuses on the box
   * and reappears if they blur without typing anything. 
   * To implement, add a data-default-text attribute to an
   * input of type text containing what you want for the default
   * text. Give the input the default_text class
   * and viola! Magic happens. Be sure to add some CSS for the
   * default_text class (which is only on the element when
   * it is displaying the default text).
  ###
  # Focus function for a default_text box
  $('.default_text').focus(->
    if $(this).hasClass 'default_text'
      $(this).val ''

    $(this).removeClass 'default_text'
  )
  
  # Blur function for a default_text box
  $('.default_text').blur(->
    if !$(this).val()
      $(this)
        .addClass('default_text')
        .val $(this).data 'default-text'
  )
  
  # Add in the default value on load (if applicable)
  $('.default_text').trigger 'blur'
  
  $('.social').hover(
    -> fade_social $(this), 'in'
    -> fade_social $(this), 'out'
  )
  
  $('.social').fadeTo(
    400
    .33
  )

fade_social = (icon, direction)->
  if direction == 'in'
    val = 1
  else
    val = .33

  icon.clearQueue()
  icon.fadeTo 400, val
