extends Node

var GRID = []
var DAY: int = 0
# Starting date for the game in unix time (2036-01-26)
const STARTING_DATE: int = 2084889600

# Maybe we can make this a const if we don't plan on making this variable
const SECONDS_PER_TICK: int = 10

# Resources
