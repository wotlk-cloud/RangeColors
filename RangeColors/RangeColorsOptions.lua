
---------------------------------------------------
-- Global vars
---------------------------------------------------

RangeColors_SavedVars = {};

---------------------------------------------------
-- Local vars
---------------------------------------------------


---------------------------------------------------
-- RangeColors.OptionsSetup
---------------------------------------------------
function RangeColors.OptionsSetup()
	InterfaceOptions_AddCategory(RangeColors_OptionsPanel);
end


---------------------------------------------------
-- RangeColors.OptionsDefault
---------------------------------------------------
function RangeColors.OptionsDefault()
	RangeColors_SavedVars.RangeColor = RangeColors.DefaultRangeColor;
	RangeColors_SavedVars.ManaColor = RangeColors.DefaultManaColor;
end


---------------------------------------------------
-- RangeColors.OptionsRefresh
---------------------------------------------------
function RangeColors.OptionsRefresh()
	RangeColors_OptionsPanelRangeColorNormalTexture:SetVertexColor(RangeColors_SavedVars.RangeColor.r, 
		RangeColors_SavedVars.RangeColor.g, RangeColors_SavedVars.RangeColor.b);
	RangeColors_OptionsPanelManaColorNormalTexture:SetVertexColor(RangeColors_SavedVars.ManaColor.r, 
		RangeColors_SavedVars.ManaColor.g, RangeColors_SavedVars.ManaColor.b);
end


---------------------------------------------------
-- RangeColors.OptionsOkay
---------------------------------------------------
function RangeColors.OptionsOkay()
	RangeColors_SavedVars.RangeColor.r, RangeColors_SavedVars.RangeColor.g, 
		RangeColors_SavedVars.RangeColor.b 
		= RangeColors_OptionsPanelRangeColorNormalTexture:GetVertexColor();
	RangeColors_SavedVars.ManaColor.r, RangeColors_SavedVars.ManaColor.g, 
		RangeColors_SavedVars.ManaColor.b 
		= RangeColors_OptionsPanelManaColorNormalTexture:GetVertexColor();
end


---------------------------------------------------
-- RangeColors.SwatchOnClick
---------------------------------------------------
function RangeColors.SwatchOnClick(self)
	local info = {};
	info.extraInfo = _G[self:GetName().."NormalTexture"];
	info.r, info.g, info.b = info.extraInfo:GetVertexColor();
	info.swatchFunc = RangeColors.SetColor;
	OpenColorPicker(info);
end


---------------------------------------------------
-- RangeColors.SetColor
---------------------------------------------------
function RangeColors.SetColor()
	if (not ColorPickerFrame:IsVisible()) then
		ColorPickerFrame.extraInfo:SetVertexColor(ColorPickerFrame:GetColorRGB());
	end
end


RangeColors.OptionsDefault();
