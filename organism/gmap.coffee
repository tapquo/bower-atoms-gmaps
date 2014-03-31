###
@TODO

@namespace Atoms.Molecule
@class GMapFullScreen

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Organism.GMap extends Atoms.Organism.Section

  @extends  : true

  @template : """
    <section {{#if.id}}id="{{id}}"{{/if.id}}></section>
  """

  @available: ["Atom.Input", "Atom.Button", "Atom.GMap", "Molecule.Form"]

  @events   : ["menu"]

  constructor: ->
    @default =
      style   : "menu form",
      children: [
        "Atom.GMap": id: "instance", events: ["query"]
      ,
        "Atom.Button": icon: "navicon", style: "small"
      ,
        "Molecule.Form": events: ["submit"], children: [
          "Atom.Input": name: "address", placeholder: "Type a address", required: true
        ,
          "Atom.Button": icon: "search", text: "Search", style: "fluid accept"
        ]
      ]
    super

  onFormSubmit: (event, form) ->
    event.preventDefault()
    @instance.query form.value().address
    false

  onGMapQuery: (places) ->
    @instance.clean()
    if places.length > 0
      @instance.marker places[0].position
      @instance.center places[0].position, zoom = 16
    false

  onButtonTouch: (event) ->
    event.preventDefault()
    @bubble "menu", event
    false