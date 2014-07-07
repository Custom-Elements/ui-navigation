#ui-navigation
IOS inspired navigation stack. This consists of a `ui-navigation` element
wrapped around and number of `ui-view` elements.

Inside each screen, you decorate elements with `push-screen="id"` attributes so
that clicking those elements automaticaly navigates. No need to put in any
event handlers, this is all declarative.


    Polymer 'ui-navigation',

##Events

##Attributes and Change Handlers
###view
This is a reference to the current view element.

###views
This is an array that is the view stack.

##Methods
###push
Push to a new view by specifying the id.

      push: (idOrElement) ->
        if @view
          @view.setAttribute 'history', ''
          @views.push @view
        if idOrElement.tagName?
          @view = idOrElement
        else
          @view = @querySelector idOrElement
        @view.setAttribute 'current', ''

###pop
Pop the current view and go back. This will not let you pop if there is
nowhere else to go.

##Event Handlers
Navigation is a click handling that will look from the source element up
the parents until a `push-screen` attribute is found, then will `push`.

      navigate: (evt) ->
        recurse = (element) =>
          if element
            if element.getAttribute 'push-screen'
              @push element.getAttribute 'push-screen'
            else
              recurse element.parentElement
        recurse evt.target

##Polymer Lifecycle

      created: ->
        @view = undefined
        @views = []

      ready: ->

      attached: ->
        @push @querySelector 'ui-view'

      domReady: ->

      detached: ->
