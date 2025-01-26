extends Control


@onready var bidderOne = $Bidder1
@onready var bidderTwo = $Bidder2
@onready var bidderThree = $Bidder3

func set_bid_card(label: String, name: String, description: String, logo: String, card_index: int):
	match(card_index):
		0:
			bidderOne.set_everything(label, name, description, logo)
		1:
			bidderTwo.set_everything(label, name, description, logo)
		2:
			bidderThree.set_everything(label, name, description, logo)
