-- title:  Tiny Gun Generator
-- author: congusbongus
-- desc:   Randomly generate pixel gun icons
-- script: moon

S_UPPER=0
S_GRIP=64
S_MAG=80
S_STOCK=96
S_SCOPE=128
S_BARREL=144
S_FGRIP=112

N_PARTS = {
	upper:18,
	grip:16,
	mag:13,
	stock:15,
	scope:8,
	barrel:8,
	fgrip:4,
}

indices = {
	upper:0,
	grip:0,
	mag:0,
	stock:0,
	scope:0,
	barrel:0,
	fgrip:0,
}

modwrap=(x,m)->
	(x%m+m)%m

class Menu
    new:(x=0,y=0,index=1)=>
        @x=x
        @y=y
        @index=index
        @items={}
    
    add:(text)=>
        table.insert(@items,text)

    prev:=>
        i=@index-1
        if i<1
            @index=#@items
        else
            @index=i
    
    next:=>
        i=@index+1
        if i>#@items
            @index=1
        else
            @index=i
    
    draw:(sel="> ",usel="  ",spc=10,col=15)=>
        for k,v in ipairs(@items)
            dy=@y+(k-1)*spc
			prefix=usel
			if @index==k
				prefix=sel
			suffix=""
			if k<#@items
				suffix=" "..indices[v]
			print prefix..v..suffix,@x,dy,col

menu = Menu 140,20
menu\add "upper"
menu\add "grip"
menu\add "mag"
menu\add "stock"
menu\add "scope"
menu\add "barrel"
menu\add "fgrip"
menu\add "shuffle..."

drawgun=(x,y,scale)->
	-- Draw stock
	spr indices.stock+S_STOCK,x-(8-1)*scale,y+4*scale,0,scale,0,0,1,1
	-- Draw scope
	spr S_SCOPE+indices.scope*2,x,y-3*scale,0,scale,0,0,1,1
	spr S_SCOPE+indices.scope*2+1,x+8*scale,y-3*scale,0,scale,0,0,1,1
	-- Draw forward grip
	spr indices.fgrip+S_FGRIP,x+(12-1)*scale,y+(8-1)*scale,0,scale,0,0,1,1
	-- Draw barrel
	spr S_BARREL+indices.barrel*2,x+8*scale,y+1*scale,0,scale,0,0,1,1
	spr S_BARREL+indices.barrel*2+1,x+8*scale,y+1*scale,0,scale,0,0,1,1
	-- Draw upper
	spr S_UPPER+indices.upper*2,x,y+1*scale,0,scale,0,0,1,1
	spr S_UPPER+indices.upper*2+1,x+8*scale,y+1*scale,0,scale,0,0,1,1
	-- Draw grip
	spr indices.grip+S_GRIP,x,y+(8-1)*scale,0,scale,0,0,1,1
	-- Draw mag
	spr indices.mag+S_MAG,x+(8-1)*scale,y+(8-1)*scale,0,scale,0,0,1,1

export TIC=->
	if btnp 0	-- up
		menu\prev!
	if btnp 1	-- down
		menu\next!
	if menu.index<#menu.items
		var=menu.items[menu.index]
		if btnp(2) or btnp(5)	-- left or B
			indices[var]=modwrap indices[var]-1,N_PARTS[var]
		if btnp(3) or btnp(4)	-- right or A
			indices[var]=modwrap indices[var]+1,N_PARTS[var]
	else
		-- Shuffling
		if btnp(2) or btnp(5) or btnp(3) or btnp(4)
			for i=1,#menu.items-1
				var=menu.items[i]
				indices[var]=math.random(N_PARTS[var])-1

	cls 0
	-- Draw gun in multiple scales
	drawgun 45,0,1
	drawgun 40,12,2
	drawgun 35,35,3
	drawgun 30,70,4
	menu\draw!

-- <TILES>
-- 000:0000000000000000000000000000000000aaaaee0a77aaee0aaaaaaa00a00000
-- 001:00000000000000000000000000000000eeee0000eeee0000aaa0000000000000
-- 002:0000000000000000000000000000eeee000efffa000e777e000eeeee00000000
-- 003:00000000000000000000000000e00000aaa00000eee000000000000000000000
-- 004:000000000000000000000000000000000000000000eeaaee0eeaaeee00e00000
-- 005:0000000000000000000000000000000000000000eee00000eaa0000000000000
-- 006:00000000000000000000000000000000000eaaee00e555ee0055555500000000
-- 007:00000000000000000000000000000000aaa7000055550000aaaa000000000000
-- 008:000000000000000000000000000000000aaaaaaa011111110111111100007000
-- 009:00000000000000000000000000000000a99000001999a0001999000000000000
-- 010:0000000000000000000000000000000000eaaa110e7777770a11111100000000
-- 011:00000000000000000000000000000000aaa77000777770001100000000000000
-- 012:0000000000000000000000000000700000f77aaa0077777700a1161100000000
-- 013:0000000000000000000000000700000077a00000777100001111100000000000
-- 014:000000000000000000000000000000000fe00007feeaaaaae77777770e000000
-- 015:0000000000000000000000000000000000007000eeeee0007777700000000000
-- 016:00000000000000000000000000000007000e11ee00071177000eeeee00000000
-- 017:00000000000000000000000000700000eee0000077777000eee0000000000000
-- 018:0000000000000000000000000000ff70000777770077eeee0077777700000000
-- 019:0000000000000000000000000000000000000000000000007000000000000000
-- 020:0000000000000000000000000000000000000000044444444444444444400000
-- 021:0000000000000000000000000000000000000000444000004440000000000000
-- 022:0000000000000000000000000000000000000000004999990099999900000000
-- 023:0000000000000000000000000000000000000000944000009440000000000000
-- 024:0000000000000000000000000000000000000000007777770011111100000000
-- 025:0000000000000000000000000000000000100000111000001111100000000000
-- 026:0000000000000000000000000000100000aa7777001111110011111100000000
-- 027:0000000000000000000000000011000077010000111110001111100001110000
-- 028:0000000000000000000000002222222722222222222222222222222200000000
-- 029:0000000000000000000000007777000077770000111111001111110000000000
-- 030:0000000000000000000000000000000000000000777777ae777777ae00000000
-- 031:0000000000000000000000000000000000002000555552225555522200000000
-- 032:0000000000000000000000000000000000e0000000eeeeee04aaaaaa04400000
-- 033:0000000000000000000000000000000000000000eee99700aa99000000000000
-- 034:0000000000000000000000000100000001111111077777770777777700000000
-- 035:000000000000000000000000000e000011110000777711107777111000000000
-- 064:00000000000110070001177700711e0000711e0000011e00000eee0000000000
-- 065:004000000444e00e33344eee3340000033400000000000000000000000000000
-- 066:00000000000ff007000ff77000ffe00000ffe00000eee0000000000000000000
-- 067:0000000000057705000577550077770000777000007770000000000000000000
-- 068:0000000000009001000991100009900000099000000000000000000000000000
-- 069:0000000000077007000aa7770077100000771000001110000000000000000000
-- 070:00000000000077010000a7100000aa0000000000000000000000000000000000
-- 071:000000000077a00100eaa11000aa70000ea7000000e700000000000000000000
-- 072:000000000000aa070000aa770000aa000000aa00000177000000770000007700
-- 073:0000000000077071001777100000700000000000000000000000000000000000
-- 074:000000000000a00a0000eaaa000ea000000a7000000000000000000000000000
-- 075:0000000000777007007717700001100000011000000000000000000000000000
-- 076:0000000000000101000011100000110000001100000000000000000000000000
-- 077:0000000000005005000555500005500000051000000000000000000000000000
-- 078:0000000000022005000200500002050000055000000000000000000000000000
-- 079:0000000000007007000077770007700a00077aa0000000000000000000000000
-- 081:0000000007a0000007a000000a10000000000000000000000000000000000000
-- 082:00e000000ae000000a700000077000000a7000000a7000000a70000000000000
-- 083:000000000a7a70000a7a70000777100000000000000000000000000000000000
-- 084:0000000007000000070000000700000000000000000000000000000000000000
-- 085:0000000002121000021210000111100000000000000000000000000000000000
-- 086:000000000a77a0000a7700000a77000000570000000000000000000000000000
-- 087:000000000aaae0000aaee0000aae00000aae0000000000000000000000000000
-- 088:000000000a7100000a71000000a71000000a71000000a1000000000000000000
-- 089:0000000001111000022200000222000002220000011100000000000000000000
-- 090:000000000a7a00000a7a00000a7aa00000a7a00000aa7a00000aa00000000000
-- 091:0000000007171000071710000071710000771710000771100000110000000000
-- 092:0000000001210000012100000121000001211000001210000011110000011000
-- 097:0000000000000000000000e7000000ee000000ee000000110000001000000000
-- 098:00000000000000000aaaaeee0a7777770a777770011117770000007700000000
-- 099:0000000000000000099999990999990009990000000000000000000000000000
-- 100:0000000000000000011111990111999901999000019900000000000000000000
-- 101:0000000000009991499999994999000949900099499999900000000000000000
-- 102:000000000000000000000000000001aa00000100000001000000000000000000
-- 103:000000000000000000a5555500a5555500a5500000a500000005000000050000
-- 104:0000000000000000211111112111111122222222222222222222000020000000
-- 105:00000000000000000555555505555555055aa000055a00000000000000000000
-- 106:0000000000000000071111110777770007000000070000000000000000000000
-- 107:0000000000000000a1111111a1111111a1111a00a111a000a11a000000000000
-- 108:0000000000000000111111111111111111001100110011001111100011100000
-- 109:0000000000000000009999990044444400444400004440000044000000000000
-- 110:000000000000000100e1111100a7777700a7777700e0000000e0000000000000
-- 113:0000000005500000055000000550000005100000000000000000000000000000
-- 114:0000000001000000010000000100000001000000010000000000000000000000
-- 115:0000000000eaea0000aaaa000000000000000000000000000000000000000000
-- 130:0000000000000000000000000000000000000000a1eeeee0a1eeeee011110000
-- 132:000000000000000000000000000000000000000000000000777777aa77777700
-- 133:000000000000000000000000000000000000000000000000a770000007700000
-- 134:000000000000000000000000000000000000000000000000eeeaaaae0000a000
-- 135:000000000000000000000000000000000000000000000000eeea0000e0000000
-- 136:0000000000000000000000000000000000000000000005000aaa77770aaa7777
-- 137:0000000000000000000000000000000000000000000a000077aa000077aa0000
-- 138:00000000000000000000000000000000000000000000000000aaaaaa00aaaaaa
-- 139:000000000000000000000000000000000000000000000000a0000000a0000000
-- 140:0000000000000000000000000000000000000000ee000000eeaaaaaa00a00000
-- 141:000000000000000000000000000000000000000000000000a555200005555200
-- 142:00000000000000000000000000000000000000000e1111110a0000000aa00000
-- 143:0000000000000000000000000000000000000000000000001000000001000000
-- 146:0000000000000000000000000000000000000000111111111111111100000000
-- 148:0000000000000000000000000000000000000000999999919999999000000000
-- 149:0000000000000000000000000000000001000000111000000000000000000000
-- 150:000000000000000000000000000000000000000044444aaa44444aaa00000000
-- 151:0000000000000000000000000000000000000000aaa00000aaa0000000000000
-- 152:00000000000000000000000000000000000000002277aa772277aa7700000000
-- 153:0000000000000000000000000000000000000000110000001100000000000000
-- 154:0000000000000000000000000000000000a00000111a00001111aaaa00000000
-- 156:000000000000000000000000000000009999900099999aaa9990000000000000
-- 158:0000000000000000000000000000000000000000ee999977a999900000000000
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <PALETTE>
-- 000:140c1c302c3030346d402428714c304c5548d04648757161597dced27d2c9195916daa2cd2aa996dc2cababebedeeed6
-- </PALETTE>

