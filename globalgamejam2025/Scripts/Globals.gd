extends Node

const Message = preload("res://Scripts/GameMechanics/Messaging/Message.gd")

var GRID_SIZE = Vector2(8,8)
var GRID = []
var DAY: int = 0
# Starting date for the game in unix time (2036-01-26)
const STARTING_DATE: int = 2084889600

# Maybe we can make this a const if we don't plan on making this variable
const SECONDS_PER_TICK: int = 10

# Resources
var funds: int = 0
var life_support: int = 0
var fuel: int = 0
var minerals: int = 0
var alloys: int = 0

# Use res://Scripts/GameMechanics/Messaging/Messaging.gd to interact with this
# There should already be a MessagingHandler node in the MainGame scene
# that deals with this, so try to use that if possible.
var message_queue: Array[Message] = []
