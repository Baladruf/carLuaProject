

local tools = {}

local providers = {
	"picsum.photos",
	"loremflickr.com",
	"lorempixel.com"
}

function tool.getRandomImg(width,height, tag, provider)

	width = width or 1920
	height = height or 1080
	tag = tag or ""

	provider = provider or math.random(3)

	return "https://"..provider.."/"..width.."/"..height.."/"..tag 
end 

return tools