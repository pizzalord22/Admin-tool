---
--- Created by mark.
--- DateTime: 6-9-2017 11:22
---

-- wolfpack  STEAM_0:1:96433555

admin = {
    CreateClientConVar( "godmode", "0", true, false ),
    CreateClientConVar( "noclip", "0", true, false ),
    CreateClientConVar( "cloak", "0", true, false ),
    CreateClientConVar( "onDuty", "0", true, false ),
    CreateClientConVar( "warnName", "player", true, false),
    CreateClientConVar( "warnReason", "reason", true, false)
}

concommand.Add( "admin_menu", function()

    --- set the color for the buttons
    local textColor = Color( 255, 255, 255 )
    local offColor = Color( 200, 200, 200 )
    local onColor = Color( 255, 255, 255 )

    --- create row vars ( y distance in pixels )
    local rowOne = 30
    local rowTwo = 75
    local rowThree = 120
    local rowFour = 165

    --- create line vars ( x distance in pixels )
    local lineOne = 10
    local lineTwo = 145
    local lineThree = 280

    local buttonColor = Color( 0,0,255 )
    local AdminFont = "Trebuchet24"

    local Frame = vgui.Create("DFrame" )
    Frame:SetTitle( "Admin tool made by Pizza" )
    Frame:SetVisible( true )
    Frame:SetDraggable( true )
    Frame:ShowCloseButton( true )
    Frame:SetSize( 500, 300)
    Frame:Center()
    Frame:MakePopup()
    Frame.Paint = function()
        draw.RoundedBox( 0, 0, 0, Frame:GetWide(), Frame:GetTall(), Color( 0, 0, 0))
    end

    -- buttons
    local godmodeButton = vgui.Create( "DButton", Frame )
    if GetConVarNumber("godmode" ) == 1 then
        godmodeButton:SetText( "godmode ON" )
        godmodeButton:SetTextColor( onColor )
    elseif GetConVarNumber( "godmode" ) == 0 then
        godmodeButton:SetText ( "godmode OFF" )
        godmodeButton:SetTextColor ( offColor )
    end
    godmodeButton:SetFont( AdminFont )
    godmodeButton:SetPos( lineOne, rowOne)
    godmodeButton:SetSize( 130, 30)
    godmodeButton.Paint = function()
        draw.RoundedBox( 0, 0, 0, Frame:GetWide(), Frame:GetTall(), buttonColor)
    end

    local noclipButton = vgui.Create( "DButton", Frame)
    if GetConVarNumber( "noclip" ) == 0 then
        noclipButton:SetText( "noclip ON" )
        noclipButton:SetTextColor( onColor )
    elseif GetConVarNumber( "noclip" ) == 1 then
        noclipButton:SetText( "noclip oFF" )
        noclipButton:SetTextColor( offColor )
    end
    noclipButton:SetFont( AdminFont )
    noclipButton:SetPos(  lineOne, rowTwo )
    noclipButton:SetSize( 130, 30 )
    noclipButton.Paint = function()
        draw.RoundedBox( 0, 0, 0, Frame:GetWide(), Frame:GetTall(), buttonColor )
    end

    local warnName = vgui.Create( "DComboBox", Frame)
    warnName:SetValue( "select a player" )
    warnName:SetPos( lineOne, rowThree )
    warnName:SetSize( 130, 30)
    for k,v in pairs( player.GetAll() ) do
        warnName:AddChoice( "" .. v )
    end
    warnName.OnSelect = function( panel, index, value )
        RunConsoleCommand( "warnName", value )
    end

    local warnReason = vgui.Create( "DTextEntry", Frame )
    warnReason:SetPos( lineTwo, rowThree )
    warnReason:SetSize( 130, 30 )
    warnReason:SetText( "reason for warning" )
    warnReason.OnEnter = function()
        RunConsoleCommand( "say", "!warn " .. GetConVarString( "warnName" ) .. " " .. GetConVarString( "warnReason" ) )
    end

    -- button actions
    godmodeButton.DoClick = function()
        if GetConVarNumber( "godmode" ) == 0 then
            godmodeButton:SetText( "godmode ON" )
            godmodeButton:SetTextColor( onColor )
            RunConsoleCommand ( "godmode", 1 )
            RunConsoleCommand ( "ulx", "god" )
        elseif GetConVarNumber( "godmode" ) == 1 then
            godmodeButton:SetText( "godmode OFF" )
            godmodeButton:SetTextColor( offColor)
            RunConsoleCommand( "godmode", 0)
            RunConsoleCommand ( "ulx", "ungod" )
        end
    end

    noclipButton.DoClick = function()
        if GetConVarNumber( "noclip" ) == 0 then
            noclipButton:SetText( "noclip ON" )
            noclipButton:SetTextColor( onColor )
            RunConsoleCommand( "noclip", 1)
        elseif GetConVarNumber( "noclip" ) == 1 then
            noclipButton:SetText( "noclip OFF" )
            noclipButton:SetTextColor( offColor )
            RunConsoleCommand( "noclip", 0)
        end
        RunConsoleCommand( "ulx", "noclip" )
    end
end)