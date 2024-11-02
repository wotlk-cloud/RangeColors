-- Rewritten from scratch with a little bit of help :) from AnduinLothar's ActionButtonColors

RangeColors = {};

RangeColors.DefaultRangeColor = { r = 1.0, g = 0.2, b = 0.2 };
RangeColors.DefaultManaColor = { r = 0.2, g = 0.2, b = 1.0 };


function RangeColors.ActionButtonOnUpdate(self, elapsed)
	if ( ActionButton_IsFlashing(self) ) then
		local flashtime = self.flashtime;
		flashtime = flashtime - elapsed;
		
		if ( flashtime <= 0 ) then
			local overtime = -flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = _G[self:GetName().."Flash"];
			if ( flashTexture:IsShown() ) then
				flashTexture:Hide();
			else
				flashTexture:Show();
			end
		end
		
		self.flashtime = flashtime;
	end
	
	-- Handle range indicator
	local rangeTimer = self.rangeTimer;
	if ( rangeTimer ) then
		rangeTimer = rangeTimer - elapsed;

		if ( rangeTimer <= 0 ) then
			local outofrange = (IsActionInRange(self.action) == 0);
			local hotkey = _G[self:GetName().."HotKey"];
			
			if (hotkey:GetText() == RANGE_INDICATOR and hotkey:IsShown()) then
				hotkey:Hide();
			end
			
			if (self.OutOfRange ~= outofrange) then
				self.OutOfRange = outofrange;

				ActionButton_UpdateUsable(self);
			end

			rangeTimer = TOOLTIP_UPDATE_TIME;
		end
		
		self.rangeTimer = rangeTimer;
	end
end


function RangeColors.ActionButtonUpdateUsable(self)
	local name = self:GetName();
	local icon = _G[name.."Icon"];
	local normalTexture = _G[name.."NormalTexture"];
	local outofrange = self.OutOfRange;
	local isUsable, notEnoughMana = IsUsableAction(self.action);
	
	if (notEnoughMana) then
		local color = RangeColors_SavedVars.ManaColor;
		icon:SetVertexColor(color.r, color.g, color.b);
		normalTexture:SetVertexColor(color.r, color.g, color.b);
	elseif (isUsable and outofrange) then
		local color = RangeColors_SavedVars.RangeColor;
		icon:SetVertexColor(color.r, color.g, color.b);
		normalTexture:SetVertexColor(color.r, color.g, color.b);
	elseif (isUsable) then
		icon:SetVertexColor(1.0, 1.0, 1.0);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	end
end


-- Hook for checking button range
ActionButton_OnUpdate = RangeColors.ActionButtonOnUpdate;

-- Replace function for setting button color
ActionButton_UpdateUsable = RangeColors.ActionButtonUpdateUsable;
