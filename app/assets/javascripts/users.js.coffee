# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).ready ->
  setTimeout ->
    liveSource = new EventSource('/user/live')
    liveSource.addEventListener 'MyXandO:user.create', (e) ->
      users = jQuery.parseJSON(e.data)
      users = jQuery.parseJSON(users) if typeof(users) == 'string'
      $('#users_online').html HandlebarsTemplates['users/online'] {online_users:users}
      return
    liveSource.addEventListener 'MyXandO:user.game.invite', (e) ->
      user = jQuery.parseJSON(e.data)
      user = jQuery.parseJSON(user) if typeof(user) == 'string'
      console.log(user)
      window.location = user.game_url if user.opponent == $('meta[name=uuid]').attr('content')
      return
    return
   , 1
