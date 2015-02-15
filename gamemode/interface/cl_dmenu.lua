local function ShowDmenu()
	local ply = LocalPlayer()
	
	CloseDermaMenus()
	
	-- Base Setup
	local base = vgui.Create("DMenu")
	base:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 275)
	base:SetMaxHeight(ScrH())
	base:SetMouseInputEnabled(true)
	base:SetKeyboardInputEnabled(true)
	gui.EnableScreenClicker(true)
	function base:Paint(w, h)
	end
	
	
	local base2 = vgui.Create("DPanel", base)
	base2:SetSize(770, 550)
	base2:SetPos(0, 0)
	function base2:Paint(w, h)
		draw.RoundedBoxEx(8, 0, 0, w, h, Color(16, 133, 119, 255), false, false, true, true )
	end
	
	
	--local base = vgui.Create("DFrame", base2)
	--base:SetSize(820, 550)
	--base:SetPos(ScrW() / 1.5 - 400, ScrH() / 1.5 - 275)
	--base:SetTitle("")
	--base:SetDraggable(false)
	--base:ShowCloseButton(true)
	--base:MakePopup()
	--base:SetIsMenu(true)
	--function base:Paint( w, h )
		--draw.RoundedBoxEx(8, 0, 0, w, h, Color(16, 133, 119, 255), false, false, true, true )
	--end
	
	
	local menu = vgui.Create("DPropertySheet", base2)
	menu:SetSize(base2:GetWide() - 10, base2:GetTall() - 5)
	menu:SetPos(5, 2)
	function menu:Paint(w, h)
		--draw.RoundedBoxEx(8, 0, 0, w, h, Color(16, 133, 119, 255), false, false, true, true )
	end

	-- Menu control bar
	
	local closeButton = vgui.Create("DButton", base2)
	closeButton:SetSize(33, 23)
	closeButton:SetPos(base2:GetWide() - 47, 2)
	closeButton:SetFont("dmmenufont")
	closeButton:SetText("×")
	function closeButton:DoClick()
		CloseDermaMenus()
		gui.EnableScreenClicker(false)
		GUIToggled = false
	end
	function closeButton:Paint(w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 255), false, true, false, true )
		draw.RoundedBoxEx(0, 1, 1, w - 2, h - 2, Color(255, 255, 255, 255), false, true, false, true )
	end
	
	
	local foop = vgui.Create("DLabel", base2)
	foop:SetPos(10, 0)
	foop:SetSize(500, 24)
	foop:SetFont("dmfont2")
	foop:SetText("Minimized - Press F3 to release mouse")
	foop:SetVisible(false)
	
	
	local minimizeButton = vgui.Create("DButton", base2)
	minimizeButton:SetSize(33, 23)
	minimizeButton:SetPos(closeButton:GetPos() - minimizeButton:GetWide() * 2, 2)
	minimizeButton:SetFont("dmmenufont")
	minimizeButton:SetText("▬")
	function minimizeButton:DoClick()
		
		if base:GetWide() == 350 then
			base:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 275)
			base2:SetSize(770, 550)
			menu:SetVisible(true)
			closeButton:SetPos(base2:GetWide() - 43, 2)
			minimizeButton:SetPos(base2:GetWide() - 109, 2)
			GUIToggled = false
			foop:SetVisible(false)
			menu:SetVisible(false)
		else
			base:SetPos(ScrW() - 355, ScrH() - 30)
			base2:SetSize(350, 30)
			base:KillFocus()
			menu:SetVisible(false)
			closeButton:SetPos(base2:GetWide() - 43, 2)
			minimizeButton:SetPos(base2:GetWide() - 76, 2)
			gui.EnableScreenClicker(false)
			foop:SetVisible(true)
			menu:SetVisible(false)
		end
	end
	function minimizeButton:Paint(w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 255), true, false, true, false )
		draw.RoundedBoxEx(0, 1, 1, w - 2, h - 2, Color(255, 255, 255, 255), true, false, true, false )
	end
	
	
	local maximizeButton = vgui.Create("DButton", base2)
	maximizeButton:SetSize(33, 23)
	maximizeButton:SetPos(closeButton:GetPos() - maximizeButton:GetWide(), 2)
	maximizeButton:SetFont("dmmenufont")
	maximizeButton:SetText("⬜")
	function maximizeButton:DoClick()
		if base2:GetSize() == 770 then
			base:SetPos(0, 0)
			base2:SetSize(ScrW(), ScrH())
			menu:SetSize(base2:GetWide() - 10, base2:GetTall() - 5)
			closeButton:SetPos(base2:GetWide() - 43, 2)
			maximizeButton:SetPos(base2:GetWide() - 76, 2)
			minimizeButton:SetVisible(false)
		else
			base:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 275)
			base2:SetSize(770, 550)
			menu:SetSize(base2:GetWide() - 10, base2:GetTall() - 5)
			closeButton:SetPos(base2:GetWide() - 43, 2)
			maximizeButton:SetPos(base2:GetWide() - 76, 2)
			minimizeButton:SetPos(base2:GetWide() - 109, 2)
			minimizeButton:SetVisible(true)
		end
	end
	function maximizeButton:Paint(w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 255), false, false, false, false )
		draw.RoundedBoxEx(0, 1, 1, w - 2, h - 2, Color(255, 255, 255, 255), false, false, false, false )
	end
	
	-- Menu Tabs
	
	local function NewTab(x, y, sheet, parent, displayFont, displayName, default)
		local page = vgui.Create("DPanel", parent)
		page:SetPos(13, y + 28)
		page:SetVisible(false)
	
		local tab = vgui.Create("DTab", parent)
		tab:SetPos(x, y)
		tab:SetHeight(200)
		tab:SetFont(displayFont)
		tab:SetTextColor(Color(0, 0, 0, 255))
		tab:SetText(displayName)
		tab:SetPanel(page)
		tab:SetPropertySheet(sheet)
		function tab:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
			draw.RoundedBox(0, 2, 2, w - 4, h + 10, Color(255, 255, 255, 255))
		end
		
		if default then
			page:SetVisible(true)
			tab:GetPropertySheet():SetActiveTab(tab)
			tab:MoveToFront( )
		end
		
		function tab:DoClick()
			page:SetVisible(true)
			tab:GetPropertySheet():SetActiveTab(tab)
			tab:MoveToFront( )
		end
		
		
		function page:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
			draw.RoundedBox(0, 2, 2, w - 4, h - 4, Color(255, 255, 255, 255))
			draw.RoundedBox(0, tab:GetPos() - 11, 0, tab:GetWide() - 4, 2, Color(255, 255, 255, 255))
		end
	end
	
	NewTab(13, 2, menu, base2, "dmmenufont", "Test1", true)
	NewTab(60, 2, menu, base2, "dmmenufont", "Test47777", false)
		
	--local tab1 = vgui.Create("DPanel", base2)
	--tab1:SetSize(base2:GetWide() - 25, base2:GetTall() - 25)
	--tab1:SetPos(0, 25)
		
		
	--local tab2 = vgui.Create("DPanel", base2)
	--tab2:SetSize(base2:GetWide() - 25, base2:GetTall() - 25)
	--tab2:SetPos(0, 25)
		
	--menu:AddSheet("Test", tab1, "icon16/accept.png", false, false, "Testy")
	--menu:AddSheet("Test2", tab2, "icon16/cancel.png", false, false, "Testy")
end

local function ShowMouse()
	GUIToggled = not GUIToggled
	gui.EnableScreenClicker(GUIToggled)
end

usermessage.Hook("dm_dmenu", ShowDmenu)
usermessage.Hook("dm_showmouse", ShowMouse)