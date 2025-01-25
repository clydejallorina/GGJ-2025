class_name LawEffects
extends Node

# Type: Dictionary[LawsEnum, Callable]
var Effects: Dictionary = {
	Enums.LawsEnum.RATIONING: ration_life_support,
	Enums.LawsEnum.PRESERVE: preserve_supplies,
	Enums.LawsEnum.EXPAND_HABITATION: expand_habitation_zones,
	Enums.LawsEnum.WORK_MORE: increase_working_hours,
	Enums.LawsEnum.ROUND_THE_CLOCK: round_the_clock_construction,
	Enums.LawsEnum.STOCKPILE_OVERSEER: stockpile_overseers,
	Enums.LawsEnum.CORPORATE_SUBSIDIES: corporate_subsidies,
}

var RepealEffects: Dictionary = {
	Enums.LawsEnum.RATIONING: repeal_ration_life_support,
	Enums.LawsEnum.PRESERVE: repeal_preserve_supplies,
	Enums.LawsEnum.EXPAND_HABITATION: repeal_expand_habitation_zones,
	Enums.LawsEnum.WORK_MORE: repeal_increase_working_hours,
	Enums.LawsEnum.ROUND_THE_CLOCK: repeal_round_the_clock_construction,
	Enums.LawsEnum.STOCKPILE_OVERSEER: repeal_stockpile_overseers,
	Enums.LawsEnum.CORPORATE_SUBSIDIES: repeal_corporate_subsidies,
}

func ration_life_support():
	if Globals.active_laws.has(Enums.LawsEnum.RATIONING):
		printerr("Attempted to activate a law that's already active!")
		return
	# Reduce global life support upkeep by 20%
	# Reduce industrial and mining income by 10%
	Globals.global_upkeep_multiplier *= 1.20
	Globals.income_multipliers[Enums.DomeTypeEnum.INDUSTRIAL] *= 0.90
	Globals.income_multipliers[Enums.DomeTypeEnum.MINING] *= 0.90
	Globals.active_laws.append(Enums.LawsEnum.RATIONING)

func preserve_supplies():
	if Globals.active_laws.has(Enums.LawsEnum.PRESERVE):
		printerr("Attempted to activate a law that's already active!")
		return
	# Reduce dome cost by 20%
	# Increase accident chance by 5%
	Globals.dome_construction_cost_multiplier *= 0.80
	# TODO: Accident chance
	Globals.active_laws.append(Enums.LawsEnum.PRESERVE)

func expand_habitation_zones():
	if Globals.active_laws.has(Enums.LawsEnum.EXPAND_HABITATION):
		printerr("Attempted to activate a law that's already active!")
		return
	# Increase number of worked domes per housing dome by 0.5
	# Increase housing dome life support upkeep by 10%
	# Interpreted above as "housing and life support domes upkeep increased by 10%"
	# TODO: Worked domes per housing
	Globals.upkeep_multipliers[Enums.DomeTypeEnum.HOUSING] *= 1.10
	Globals.upkeep_multipliers[Enums.DomeTypeEnum.LIFE_SUPPORT] *= 1.10
	Globals.active_laws.append(Enums.LawsEnum.EXPAND_HABITATION)

func increase_working_hours():
	if Globals.active_laws.has(Enums.LawsEnum.WORK_MORE):
		printerr("Attempted to activate a law that's already active!")
		return
	# Increase all incomes by 10%
	# Increase accident chance by 5%
	# Increase life support upkeep by 5%
	Globals.global_income_multiplier = 1.10
	# TODO: Accident chance
	Globals.upkeep_multipliers[Enums.DomeTypeEnum.LIFE_SUPPORT] *= 1.05
	Globals.active_laws.append(Enums.LawsEnum.WORK_MORE)

func round_the_clock_construction():
	if Globals.active_laws.has(Enums.LawsEnum.ROUND_THE_CLOCK):
		printerr("Attempted to activate a law that's already active!")
		return
	# Reduce overall build time by 20%
	# Increase build cost by 10%
	Globals.dome_construction_time_multiplier *= 0.80
	Globals.dome_construction_cost_multiplier *= 1.10
	Globals.active_laws.append(Enums.LawsEnum.ROUND_THE_CLOCK)

func stockpile_overseers():
	if Globals.active_laws.has(Enums.LawsEnum.ROUND_THE_CLOCK):
		printerr("Attempted to activate a law that's already active!")
		return
	# Increase audit accuracy by 50%
	# TODO: Auditing
	Globals.active_laws.append(Enums.LawsEnum.ROUND_THE_CLOCK)

func corporate_subsidies():
	if Globals.active_laws.has(Enums.LawsEnum.CORPORATE_SUBSIDIES):
		printerr("Attempted to activate a law that's already active!")
		return
	# Reduce cost for bids by 10%
	# Martian Reputation hit?
	# TODO: Bidding cost
	# TODO: Reputation
	Globals.active_laws.append(Enums.LawsEnum.CORPORATE_SUBSIDIES)

# -------------------- [ REPEAL FUNCTIONS ] --------------------

func repeal_ration_life_support():
	if Globals.active_laws.has(Enums.LawsEnum.RATIONING):
		printerr("Attempted to activate a law that's already active!")
		return
	# Reduce global life support upkeep by 20%
	# Reduce industrial and mining income by 10%
	Globals.global_upkeep_multiplier /= 1.20
	Globals.income_multipliers[Enums.DomeTypeEnum.INDUSTRIAL] /= 0.90
	Globals.income_multipliers[Enums.DomeTypeEnum.MINING] /= 0.90
	Globals.active_laws.append(Enums.LawsEnum.RATIONING)

func repeal_preserve_supplies():
	if Globals.active_laws.has(Enums.LawsEnum.PRESERVE):
		printerr("Attempted to activate a law that's already active!")
		return
	# Reduce dome cost by 20%
	# Increase accident chance by 5%
	Globals.dome_construction_cost_multiplier /= 0.80
	# TODO: Accident chance
	Globals.active_laws.append(Enums.LawsEnum.PRESERVE)

func repeal_expand_habitation_zones():
	if Globals.active_laws.has(Enums.LawsEnum.EXPAND_HABITATION):
		printerr("Attempted to activate a law that's already active!")
		return
	# Increase number of worked domes per housing dome by 0.5
	# Increase housing dome life support upkeep by 10%
	# Interpreted above as "housing and life support domes upkeep increased by 10%"
	# TODO: Worked domes per housing
	Globals.upkeep_multipliers[Enums.DomeTypeEnum.HOUSING] /= 1.10
	Globals.upkeep_multipliers[Enums.DomeTypeEnum.LIFE_SUPPORT] /= 1.10
	Globals.active_laws.append(Enums.LawsEnum.EXPAND_HABITATION)

func repeal_increase_working_hours():
	if Globals.active_laws.has(Enums.LawsEnum.WORK_MORE):
		printerr("Attempted to activate a law that's already active!")
		return
	# Increase all incomes by 10%
	# Increase accident chance by 5%
	# Increase life support upkeep by 5%
	Globals.global_income_multiplier /= 1.10
	# TODO: Accident chance
	Globals.upkeep_multipliers[Enums.DomeTypeEnum.LIFE_SUPPORT] /= 1.05
	Globals.active_laws.append(Enums.LawsEnum.WORK_MORE)

func repeal_round_the_clock_construction():
	if Globals.active_laws.has(Enums.LawsEnum.ROUND_THE_CLOCK):
		printerr("Attempted to activate a law that's already active!")
		return
	# Reduce overall build time by 20%
	# Increase build cost by 10%
	Globals.dome_construction_time_multiplier /= 0.80
	Globals.dome_construction_cost_multiplier /= 1.10
	Globals.active_laws.append(Enums.LawsEnum.ROUND_THE_CLOCK)

func repeal_stockpile_overseers():
	if Globals.active_laws.has(Enums.LawsEnum.ROUND_THE_CLOCK):
		printerr("Attempted to activate a law that's already active!")
		return
	# Increase audit accuracy by 50%
	# TODO: Auditing
	Globals.active_laws.append(Enums.LawsEnum.ROUND_THE_CLOCK)

func repeal_corporate_subsidies():
	if Globals.active_laws.has(Enums.LawsEnum.CORPORATE_SUBSIDIES):
		printerr("Attempted to activate a law that's already active!")
		return
	# Reduce cost for bids by 10%
	# Martian Reputation hit?
	# TODO: Bidding cost
	# TODO: Reputation
	Globals.active_laws.append(Enums.LawsEnum.CORPORATE_SUBSIDIES)
