local sv = setmetatable({},{
	__index = function(self, ind)
		if ypcall(function()game:GetService(ind)end) then
			return game:GetService(ind)
		else
			return nil
		end
	end
})

local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/loglizzy/Elerium-lib/main/lib.lua'))()
local repl = sv.ReplicatedStorage
local a = require(repl.Aero.Shared.GameSettings.ModeData)
a = getupvalue(a,1)

local rmt = {}
for i,v in pairs(repl.Aero.AeroRemoteServices:GetDescendants()) do
    if v.Parent.Name ~= 'FusionService' then
        if v:IsA('RemoteEvent') then
            rmt[v.Name] = function(...)v:FireServer(...) end
        elseif v:IsA('RemoteFunction') then
            rmt[v.Name] = function(...)v:InvokeServer(...) end
        end
    end
end

local w,flags = lib:AddWindow('gay game'),{}
local m = w:AddTab('main')

m:AddSwitch('auto transform',function(v)
    flags.trans = v
end)
m:Show()

while wait() do
    if flags.trans then
        rmt.Transformation(a:GetBestMode(game.Players.LocalPlayer).Name)
        wait(1)
    end
end
