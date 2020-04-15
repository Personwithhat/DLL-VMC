----------------------------------------------------------------        
----------------------------------------------------------------        
-- Not sure if necessary, no harm keeping this for now.
local g_bEntered = false;

----------------------------------------------------------------        
---------------------------------------------------------------- 
function OnEnter()
	if (not g_bEntered) then
		-- Moving between sub-menus causes this screen to be shown and hidden
		-- multiple times. Want to maintain the fact that there is an active popup
		-- by incrementing the turn timer semaphore once on entering the screen and
		-- have the semaphore decremented on leaving the screen.
		UI.incTurnTimerSemaphore();
		g_bEntered = true;
	end
end

----------------------------------------------------------------        
----------------------------------------------------------------  
function OnLeave()
	if (g_bEntered) then
		-- Leaving the screen
		UI.decTurnTimerSemaphore();
		g_bEntered = false;
	end
end

----------------------------------------------------------------        
----------------------------------------------------------------        
function OnShowHide( isHide, isInit )
    if( not isInit ) then
		UI.SetInterfaceMode(InterfaceModeTypes.INTERFACEMODE_SELECTION);
		if( not isHide ) then
			OnEnter();
		else
			OnLeave();
		end
    end
end
ContextPtr:SetShowHideHandler( OnShowHide );

----------------------------------------------------------------        
-- Key Down Processing
----------------------------------------------------------------
function InputHandler( uiMsg, wParam, lParam )
    if( uiMsg == KeyEvents.KeyDown ) 
	then
	if( wParam == Keys.VK_ESCAPE ) then
		UIManager:QueuePopup( Controls.GameMenu, PopupPriority.InGameMenu );
		return true;
	end
	end
	
	-- Capture and do nothing with keyboard input.
	-- Mouse is consumed as well since this is a popup.
    return true;
end
ContextPtr:SetInputHandler( InputHandler );



