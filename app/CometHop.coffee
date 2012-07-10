# CREATE SPACESHIPS
#MySpaceships = new Meteor.Collection("spaceships")

#Spaceships.insert({title : "Screw Driver", x : 500, y : 600});

Players = new Meteor.Collection("players")
Players.insert({title : "Screw Driver 2", x : 500, y : 600})


# CREATE PILOT


if Meteor.is_client 

  #Meteor.ui.render ->
  #  Template.spaceship({title: "Alyssa", x: "Hacker"})
  
  Template.spaceship.spaceship = ->
    Players.find({}, { sort: {time: -1} })

  #Template.Spaceship.events = 
  #  'click input' : ->  
  #    # template data, if any, is available in 'this'
  #    # if typeof console !== 'undefined'
  #    #   console.log "You pressed the button"


  # SHIP CONTROLS
  
  
  #Template.spaceship.positionShip = ->
  #  Meteor.defer ->
  #    # Find ship
  #    myShip = $('#player-1')
  #    myShip.css({'top': '400px', 'left': '400px'})
  #    console.log myShip



if Meteor.is_server 
  Meteor.startup ->  
    # code to run on server at startup