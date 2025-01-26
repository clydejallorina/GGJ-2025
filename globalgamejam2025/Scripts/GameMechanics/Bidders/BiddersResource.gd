extends Resource

@export var bidders: Array[Bidder]

func _init(p_bidders: Array[Bidder]=[]):
	bidders = p_bidders

func get_random_bidders() -> Array:
	# TODO: make it so that we implement the random.choices
	var random_bidders: Array[Bidder] = []
	var random_number = RandomNumberGenerator.new().randi_range(0,4)
	random_bidders.append(bidders[random_number])
	random_bidders.append(bidders[(random_number + 1) % 5])
	random_bidders.append(bidders[(random_number + 2) % 5])
	return random_bidders
