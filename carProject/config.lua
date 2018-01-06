
local aspectRatio = display.pixelHeight / display.pixelWidth

application = {
	content = {
		width = aspectRatio < 1.5 and 800 or math.floor( 1200 / aspectRatio +1),
		height = aspectRatio > 1.5 and 1200 or math.floor( 800 * aspectRatio +1),
		scale = "letterBox",
		fps = 30,

		imageSuffix = {
			["@2x"] = 1.3,
		},
	},

   notification =
    {
        iphone =
        {
            types =
            {
                "badge",
                "sound",
                "alert"
            },
            plist = {
				UIBackgroundModes = { "remote-notification" },
				FirebaseAppDelegateProxyEnabled = false,
        	}
        },
    },
}
