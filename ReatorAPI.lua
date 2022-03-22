local component = require("component")
local thread = require("thread")

local API = {}

local reactor = component.nc_fission_reactor


function API.checkState()
	return reactor.isProcessing()
end --end checkState

function API.checkEnergyLevel()
	return reactor.getEnergyStored() / reactor.getMaxEnergyStored()
end --end checkEnergyLevel

function API.checkHeatLevel()
	return reactor.getHeatLevel() / reactor.getMaxHeatLevel()
end --end cheackHeatLevel

function API.checkMaxHeatLevel()
	return reactor.getMaxHeatLevel()
end --end checkMaxHeatLevel

function API.checkEnergyChange() 
	return reactor.getEnergyChange()
end --end checkEnergyChange

function API.checkProcessHeat()
	return reactor.getReactorProcessHeat()
end --end checkProcessHeat

function API.powerOutput() 
	return reactor.getReactorProcessPower()
end --end powerOutput

function API.currentStoredPower()
	return reactor.getEnergyStored()
end --end currentStoredPower

function API.currentHeatLevel()
	return reactor.getHeatLevel()
end --end currentHeatLevel

function API.fuelName()
	return reactor.getFissionFuelName()
end --end fuelName

function API.remainingProcessTime() 
	return (reactor.getFissionFuelTime() - reactor.getCurrentProcessTime())
end --end remainingProcessTime

function API.efficiency() 
	return reactor.getEfficiency()
end --end efficiency

function API.changeReactorState()
	if API.checkState() then
		reactor.deactivate()
	else
		reactor.activate()
	end
end --end changeReactorState

function API.auto()
	if (API.checkState() == false) and (API.checkEnergyLevel() <= 0.20) and (API.checkHeatLevel() <= 0.20)then
		API.changeReactorState() --turn on reactor
	elseif (API.checkState()) and ((API.checkEnergyLevel() >= 0.80) or (API.checkHeatLevel() >= 0.80)) then
		API.changeReactorState() --turn off reactor
	end
end 


return API