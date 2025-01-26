extends Control


@onready var bidderOne = $Bidder1
@onready var bidderTwo = $Bidder2
@onready var bidderThree = $Bidder3
@export var BidderData: Resource

func _ready():
	var index = 0
	if BidderData:
		for bidder in BidderData.get_random_bidders():
			set_bid_card(bidder.cost, bidder.name, bidder.description, bidder.logo_id, index)
			index += 1

func set_bid_card(label: int, name: String, description: String, logo: String, card_index: int):
	match(card_index):
		0:
			bidderOne.set_everything(str(label), name, description, logo)
		1:
			bidderTwo.set_everything(str(label), name, description, logo)
		2:
			bidderThree.set_everything(str(label), name, description, logo)
