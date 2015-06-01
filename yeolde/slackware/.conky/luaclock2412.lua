--[[drawing a clock in conkyrc
by mrpeachy - 12 March 2010
Edited by Sector11 for personal use - 12 Mar 2012

lua_load /path/clock.lua
lua_draw_hook_pre main
TEXT
]]

require 'cairo'

function conky_main()
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
cr = cairo_create(cs)
--##############################################################################
--   SETTINGS AREA
--##############################################################################
-- image
-- how do I add images.
-- local cpu=conky_parse("${cpu}")
-- local red-1=conky_parse("${image ~/Conky/images/red_1.png -p 0,0 -s 35x35}")


--12 OR 24
-- local clock_type=24
local clock_type=12

--CLOCK SETTINGS
local clock_radius=64
local clock_centerx=64
local clock_centery=64

-- SET MARKS
--how many marks around edge
local number_marks=12 --24
--set mark length
local m_length=5
--set mark line width
local m_width=1
--set mark line cap type
local m_cap=CAIRO_LINE_CAP_ROUND
--set mark color and alpha,red blue green alpha
local mr,mg,mb,ma=1,1,1,1  --opaque white

--SET BORDER OPTIONS
local clock_border_width=0 --2
--set color and alpha for clock border
local cbr,cbg,cbb,cba=1,1,1,1  --full opaque white
--gap from clock border to hour marks
local b_to_m=5

--SECONDS HAND SETUP
--set length of seconds hand
local sh_length=12
--set hand width
local sh_width=1
--set hand line cap
local sh_cap=CAIRO_LINE_CAP_ROUND
--set seconds hand color
local shr,shg,shb,sha=0,1,1,0  --fully opaque cyan

--MINUTE HAND SETUP
--set length of minutes hand
local mh_length=56
--set hand width
local mh_width=1
--set hand line cap
local mh_cap=CAIRO_LINE_CAP_ROUND
--set minute hand color
local mhr,mhg,mhb,mha=1,1,1,1  --fully opaque white

--HOUR HAND SETUP
--set length of hour hand
local hh_length=40
--set hand width
local hh_width=2
--set hand line cap
local hh_cap=CAIRO_LINE_CAP_ROUND
--set hour hand color
local hhr,hhg,hhb,hha=1,1,1,1  --fully opaque white
--##############################################################################
--   END SETTINGS AREA
--##############################################################################

--DRAWING CODE
--draw border
cairo_set_source_rgba (cr,cbr,cbg,cbb,cba)
cairo_set_line_width (cr,clock_border_width)
cairo_arc (cr,clock_centerx,clock_centery,clock_radius,0,2*math.pi)
cairo_stroke (cr)

--DRAW MARKS
--stuff that can be moved outside of the loop, needs only be set once
--calculate end and start radius for marks
m_end_rad=clock_radius-b_to_m
m_start_rad=m_end_rad-m_length
--set line cap type
cairo_set_line_cap  (cr, m_cap)
--set line width
cairo_set_line_width (cr,m_width)
--set color and alpha for marks
cairo_set_source_rgba (cr,mr,mg,mb,ma)
--start for loop
for i=1,number_marks do
--drawing code using the value of i to calculate degrees
--calculate start point for 12 oclock mark
radius=m_start_rad
point=(math.pi/180)*((i-1)*(360/number_marks))
x=0+radius*(math.sin(point))
y=0-radius*(math.cos(point))
--set start point for line
cairo_move_to (cr,clock_centerx+x,clock_centery+y)
--calculate end point for 12 oclock mark
radius=m_end_rad
point=(math.pi/180)*((i-1)*(360/number_marks))
x=0+radius*(math.sin(point))
y=0-radius*(math.cos(point))
--set path for line
cairo_line_to (cr,clock_centerx+x,clock_centery+y)
--draw the line
cairo_stroke (cr)
end--of for loop

--TIME CALCULATIONS ###########################
if clock_type==12 then
hours=tonumber(os.date("%I")) --12 hour clock
--convert hours to seconds
h_to_s=hours*60*60
elseif clock_type==24 then
hours=tonumber(os.date("%H")) --24 hour clock
--convert hours to seconds
h_to_s=hours*60*60
end

minutes=tonumber(os.date("%M"))
--convert minutes to seconds
m_to_s=minutes*60
--get current seconds
seconds=tonumber(os.date("%S"))

--DRAW HOUR HAND ############################
--convert hours, minutes & seconds to seconds
hsecs=h_to_s+m_to_s+seconds
--calculate number of degrees for each hand per second
hsec_degs=hsecs*(360/(60*60*clock_type)) -- USING AN EQUATION INSTEAD OF TYPING THE CALCULATION IN BECAUSE THE RESULT OF 360/43200 HAS DECIMAL PLACES
--set radius we will use to calculate hand points
radius=hh_length
--set our starting line coordinates, the center of the circle
cairo_move_to (cr,clock_centerx,clock_centery)
--calculate coordinates for end of minutes hand
point=(math.pi/180)*hsec_degs
x=0+radius*(math.sin(point))
y=0-radius*(math.cos(point))
--describe the line we will draw
cairo_line_to (cr,clock_centerx+x,clock_centery+y)
--set up line attributes and draw line
cairo_set_line_width (cr,hh_width)
cairo_set_source_rgba (cr,hhr,hhg,hhb,hha)
cairo_set_line_cap  (cr, hh_cap)
cairo_stroke (cr)

--DRAW MINUTES HAND ############################
--convert minutes & seconds to seconds
msecs=m_to_s+seconds
--calculate degrees for the hand each second
msec_degs=msecs*0.1
--set radius we will use to calculate hand points
radius=mh_length
--set our starting line coordinates, the center of the circle
cairo_move_to (cr,clock_centerx,clock_centery)
--calculate coordinates for end of minutes hand
point=(math.pi/180)*msec_degs
x=0+radius*(math.sin(point))
y=0-radius*(math.cos(point))
--describe the line we will draw
cairo_line_to (cr,clock_centerx+x,clock_centery+y)
--set up line attributes and draw line
cairo_set_line_width (cr,mh_width)
cairo_set_source_rgba (cr,mhr,mhg,mhb,mha)
cairo_set_line_cap  (cr, mh_cap)
cairo_stroke (cr)

--DRAW SECOND HAND #############################
--calculate degrees for each second the hand moves
sec_degs=seconds*6
--set radius we will use to calculate hand points
radius=sh_length
--set our starting line coordinates, the center of the circle
cairo_move_to (cr,clock_centerx,clock_centery)
--calculate coordinates for end of second hand
point=(math.pi/180)*sec_degs
x=0+radius*(math.sin(point))
y=0-radius*(math.cos(point))
--describe the line we will draw
cairo_line_to (cr,clock_centerx+x,clock_centery+y)
--set up line attributes and draw line
cairo_set_line_width (cr,sh_width)
cairo_set_source_rgba (cr,shr,shg,shb,sha)
cairo_set_line_cap  (cr, sh_cap)
cairo_stroke (cr)

--##############################################################################
cairo_destroy(cr)
cairo_surface_destroy(cs)
cr=nil
end-- end main function


