# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
window.cl = ->
  console.log.apply console, arguments

$ ->
  $("#search_button").click ->
    $(this).closest("form").submit()

    false

  $("#months_list li:gt(11)").hide()
  $("#months_callout").show()
  $("#months_callout").click ->
    $(this).siblings().show()
    $(this).hide()
    $(this).closest('ul').css "overflow", "auto"

    false

  $("#links_callout .older").click ->
    callout = $(this)
    ul = callout.closest("ul")
    ul.data "page", ul.data("page") + 1
    $.getJSON ul.data("action"),
      page: ul.data("page")+'?'+ul.data("query")
      per_page: ul.data("per_page"),
      (data) ->
        $(data).each (index, val) ->
          link = $('<li class="link-line"><a href="'+val.url+'" target="_blank" class="discovery-link '+val.color_class+'" title="'+val.user.name+'<br>'+val.comment+'">'+val.title+'</a></li>')
          callout.parent().before link
          $("a", link).not(".touch a").tipsy
            html: true
            fade: true
            gravity: "w"

    false

  positionHeading()

  $(window).resize ->
    positionHeading()

  window.onscroll = ->
    posX = (if (document.documentElement.scrollLeft) then document.documentElement.scrollLeft else window.pageXOffset)
    posY = (if (document.documentElement.scrollTop) then document.documentElement.scrollTop else window.pageYOffset)
    ground = document.getElementById("s")
    title = document.getElementById("outer_title")
    groundparallax = calcParallax(300, -6, posY)
    titleparallax = 714 - (Math.floor(posY / 4))
    ground.style.backgroundPosition = "0 " + groundparallax + "px"
    if title
      title.style.top = titleparallax + "px"

  $(".post-tags [title]").not(".touch .post-tags").tipsy
    html: true
    fade: true
    delayOut: 1500

  $("[title]").not(".touch [title]").tipsy
    html: true
    fade: true
    gravity: "w"

  $(".tag-list").width(500).tagsInput(
    placeholderColor: "#808082"
    width: "100%"
  )

calcParallax = (tileheight, speedratio, scrollposition) ->
  (tileheight) - (Math.floor(scrollposition / speedratio) % (tileheight + 1))

positionHeading = ->
  width = $("#s_outer").width()
  outer_width = $("body").width()
  margin = ((outer_width - width) / 2)
  margin = margin - 534
  $("#outer_title").css("right", margin+"px")
