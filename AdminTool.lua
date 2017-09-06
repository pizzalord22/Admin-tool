---
--- Created by mark.
--- DateTime: 6-9-2017 11:22
---
admin = {
    CreateClientConVar("godmode", "0", true, false),
    CreateClientConVar("noclip", "0", true, false),
    CreateClientConVar("cloak", "0", true, false),
    CreateClientConVar("onDuty", "0", true, false)
}

concommand.Add( "admin_menu", function()

    --- set the color for the buttons
    local textColor = Color( 255, 255, 255 )
    local offColor = Color( 53, 70, 175 )
    local onColor = Color( 84, 216, 42 )

    --- create row vars ( y distance in pixels )
    local rowOne = 30
    local rowTwo = 75
    local rowThree = 120

    --- create line vars ( x distance in pixels )
    local lineOne = 10
    local lineTwo = 120
    --- local lineThree = 230

    AdminFont = "Trebuchet20"

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
    godmodeButton:SetSize( 100, 30)
    godmodeButton.Paint = function()
        draw.RoundedBox( 0, 0, 0, Frame:GetWide(), Frame:GetTall(), Color( 30,25,25 ))
    end

    local noclipButton = vgui.Create( "DButton", Frame)
    if GetConVarNumber( "noclip" ) == 0 then
        noclipButton:SetText( "noclip ON" )
        noclipButton:SetTextColor( onColor )
    end

    -- button actions
    godmodeButton.DoClick = function()
        if GetConVarNumber( "godmode" ) == 0 then
            godmodeButton:SetText( "godmode ON" )
            godmodeButton:SetTextColor( onColor )
            RunConsoleCommand ( "godmode", 1 )
            RunConsoleCommand ("ulx", "god")
        elseif GetConVarNumber( "godmode" ) == 1 then
            godmodeButton:SetText( "godmode OFF" )
            godmodeButton:SetTextColor( offColor)
            RunConsoleCommand( "godmode", 0)
            RunConsoleCommand ("ulx", "ungod")
        end
    end
end)

print( "admin tool loaded" )