# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#search_button").click ->
    $(this).closest("form").submit()

    false
  
  $('.social').hover(
    -> fade_social $(this), 'in'
    -> fade_social $(this), 'out'
  )
  
  $('.social').fadeTo(
    400
    .33
  )

  $("#months_list li:gt(11)").hide()
  $("#months_callout").show()
  $("#months_callout").click ->
    $(this).siblings().show()
    $(this).hide()
    $(this).closest('ul').css "overflow", "auto"
    return false
  
  positionHeading()

  $(window).resize ->
    positionHeading()

  window.onscroll = ->
    posX = (if (document.documentElement.scrollLeft) then document.documentElement.scrollLeft else window.pageXOffset)
    posY = (if (document.documentElement.scrollTop) then document.documentElement.scrollTop else window.pageYOffset)
    ground = document.getElementById("s")
    title = document.getElementById("outer_title")
    groundparallax = calcParallax(300, 4, posY)
    titleparallax = 714 - (Math.floor(posY / 2))
    ground.style.backgroundPosition = "0 " + groundparallax + "px"
    title.style.top = titleparallax + "px"

fade_social = (icon, direction)->
  if direction == 'in'
    val = 1
  else
    val = .33

  icon.clearQueue()
  icon.fadeTo 400, val

calcParallax = (tileheight, speedratio, scrollposition) ->
  (tileheight) - (Math.floor(scrollposition / speedratio) % (tileheight + 1))

positionHeading = ->
  width = $("#s_outer").width()
  outer_width = $("body").width()
  margin = ((outer_width - width) / 2)
  margin = margin - 534 
  $("#outer_title").css("right", margin+"px")
