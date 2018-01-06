

-- programme hello world basique
local options =
{
	text = "Coucou !",
	x = halfW,
	y = halfH,
	fontSize = 50
}

local textobject = display.newText(options)

local colors = table.loadJson("assets/ui/colors.json", system.ResourceDirectory)
table.print(colors)


