window.App ||= {}

App.init = ->
#menu principal
# Initialize collapse button
  $('.button-collapse').sideNav()

  $('ul.tabs').tabs()


  #script facebook
  window.fbAsyncInit = ->
  FB.init
    appId: '1047312255310533'
    xfbml: true
    version: 'v2.5'
  return

((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  if d.getElementById(id)
    return
  js = d.createElement(s)
  js.id = id
  js.src = '//connect.facebook.net/en_US/sdk.js'
  fjs.parentNode.insertBefore js, fjs
  return
) document, 'script', 'facebook-jssdk'

$(document).on "page:change", ->
  App.init()

