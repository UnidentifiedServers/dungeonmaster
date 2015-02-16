CreateClientConVar("dm_dmenu_red", 16, true, false)
CreateClientConVar("dm_dmenu_green", 133, true, false)
CreateClientConVar("dm_dmenu_blue", 119, true, false)
CreateClientConVar("dm_dmenu_alpha", 255, true, false)

local maximized = false

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
		local r, g, b, a = GetConVarNumber("dm_dmenu_red"), GetConVarNumber("dm_dmenu_green"), GetConVarNumber("dm_dmenu_blue"), GetConVarNumber("dm_dmenu_alpha")
		draw.RoundedBoxEx(8, 0, 0, w, h, Color(r, g, b, a), false, false, true, true )
	end
	
	minimized = false
	if maximized then
		base:SetPos(0, 0)
		base2:SetSize(ScrW(), ScrH())
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
		minimized = false
		maximized = false
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
	if maximized then
		minimizeButton:SetVisible(false)
	else
		minimizeButton:SetVisible(true)
	end
	function minimizeButton:DoClick()
		
		if base:GetWide() == 350 then
			base:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 275)
			base2:SetSize(770, 550)
			menu:SetVisible(true)
			closeButton:SetPos(base2:GetWide() - 47, 2)
			minimizeButton:SetPos(closeButton:GetPos() - minimizeButton:GetWide() * 2, 2)
			GUIToggled = false
			foop:SetVisible(false)
			minimized = false
		else
			base:SetPos(ScrW() - 355, ScrH() - 30)
			base2:SetSize(350, 30)
			base:KillFocus()
			menu:SetVisible(false)
			closeButton:SetPos(base2:GetWide() - 43, 2)
			minimizeButton:SetPos(base2:GetWide() - 76, 2)
			gui.EnableScreenClicker(false)
			foop:SetVisible(true)
			minimized = true
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
		if !maximized then
			base:SetPos(0, 0)
			base2:SetSize(ScrW(), ScrH())
			--menu:SetSize(base2:GetWide() - 10, base2:GetTall() - 5)
			--closeButton:SetPos(base2:GetWide() - 47, 2)
			--maximizeButton:SetPos(closeButton:GetPos() - maximizeButton:GetWide(), 2)
			maximized = true
			CloseDermaMenus()
			RunConsoleCommand("dm_dmenu")
		else
			base:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 275)
			base2:SetSize(770, 550)
			--menu:SetSize(base2:GetWide() - 10, base2:GetTall() - 5)
			--closeButton:SetPos(base2:GetWide() - 47, 2)
			--maximizeButton:SetPos(closeButton:GetPos() - maximizeButton:GetWide(), 2)
			--minimizeButton:SetPos(closeButton:GetPos() - minimizeButton:GetWide() * 2, 2)
			maximized = false
			CloseDermaMenus()
			RunConsoleCommand("dm_dmenu")
		end
	end
	function maximizeButton:Paint(w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 255), false, false, false, false )
		draw.RoundedBoxEx(0, 1, 1, w - 2, h - 2, Color(255, 255, 255, 255), false, false, false, false )
	end
	
	-- Menu Tabs
	
	defaultTab = true
	
	local function NewTab(x, y, sheet, parent, displayName)
		local page = vgui.Create("DPanel", parent)
		page:SetPos(13, y + 28)
		page:SetSize(parent:GetWide() - 26, parent:GetTall() - 43)
		page:SetVisible(false)
		
		
		local tab = vgui.Create("DTab", parent)
		tab:SetPos(x, y + 8)
		tab:SetFont("dmmenufont")
		tab:SetTextColor(Color(0, 0, 0, 255))
		tab:SetText(displayName)
		tab:SetPanel(page)
		tab:SetPropertySheet(sheet)
		tab:SetWidth(tab:GetContentSize() + 20)
		function tab:Paint(w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
				draw.RoundedBox(0, 2, 2, w - 4, h + 10, Color(255, 255, 255, 255))
		end
		
		if defaultTab then
			page:SetVisible(true)
			tab:GetPropertySheet():SetActiveTab(tab)
			tab:MoveToFront( )
			tab:SetPos(x, y)
			defaultTab = false
		end
		
		function tab:DoClick()
			page:SetVisible(true)
			tab:GetPropertySheet():SetActiveTab(tab)
			tab:MoveToFront( )
		end
		
		function tab:Think()
			if !tab:IsActive() then
				tab:SetPos(x, y + 8)
			else 
				tab:SetPos(x, y)
			end
			
			if minimized then
				tab:SetPos(200, 200)
			end
		end
		
		function page:Paint(w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
			draw.RoundedBox(0, 2, 2, w - 4, h - 4, Color(255, 255, 255, 255))
			draw.RoundedBox(0, tab:GetPos() - 11, 0, tab:GetWide() - 4, 2, Color(255, 255, 255, 255))
		end
		
		return page, tab:GetBounds()
	end
	
	-- About Tab
	
	tabPage, tabX, tabY, tabWide, tabTall = NewTab(13, 2, menu, base2, "About")
	
	local info = vgui.Create("DHTML", tabPage)
	info:SetPos(0, 0)
	info:SetSize(tabPage:GetWide(), tabPage:GetTall())
	info:OpenURL("http://forums.unidentified.cf/index.php/topic,252.0.html")
	
	-- Options Tab
	--local tabX = 10
	--local tabWide = 0
	
	tabPage, tabX, tabY, tabWide, tabTall = NewTab(tabX + tabWide + 3, 2, menu, base2, "Options")
	
	local list = vgui.Create("DCategoryList", tabPage)
	list:SetPos(2, 2)
	list:SetSize(tabPage:GetWide() - 4, tabPage:GetTall() - 2)
	
	local option1 = vgui.Create("DForm", list)
	list:AddItem(option1)
	option1:SetName("DMenu Colour")
	
	local resetButton = vgui.Create("DButton", option1)
	resetButton:SetText("Reset Colour Scheme")
	
	function resetButton:DoClick()
		RunConsoleCommand("dm_dmenu_red", 16)
		RunConsoleCommand("dm_dmenu_green", 133)
		RunConsoleCommand("dm_dmenu_blue", 119)
		RunConsoleCommand("dm_dmenu_alpha", 255)
	end
	
	local colorPicker = vgui.Create("DColorMixer", option1)
	colorPicker:SetHeight(tabPage:GetTall() - 75)
	colorPicker:SetConVarR("dm_dmenu_red")
	colorPicker:SetConVarG("dm_dmenu_green")
	colorPicker:SetConVarB("dm_dmenu_blue")
	colorPicker:SetConVarA("dm_dmenu_alpha")
	
	option1:AddItem(resetButton)
	option1:AddItem(colorPicker)
	
	-- Controls Tab
	
	tabPage, tabX, tabY, tabWide, tabTall = NewTab(tabX + tabWide + 3, 2, menu, base2, "Controls")
	
	if ply:Team() == 3 then
		-- Dungeon Master's Settings Tab
	
		tabPage, tabX, tabY, tabWide, tabTall = NewTab(tabX + tabWide + 2, 2, menu, base2, "Game Setup")
				
		-- Dungeon Master's Tool Tab
		
		tabPage, tabX, tabY, tabWide, tabTall = NewTab(tabX + tabWide + 3, 2, menu, base2, "Master's Tools")
	end
	
	if ply:IsAdmin() then
		-- Admin Control Tab
	
		tabPage, tabX, tabY, tabWide, tabTall = NewTab(tabX + tabWide + 2, 2, menu, base2, "Admin Controls")
	end
	
		
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