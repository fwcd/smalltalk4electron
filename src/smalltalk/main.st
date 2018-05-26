createBrowserWindow := [
	| width height |
	width := 800.
	height := 600.

	">> Create the browser window".
	JS get:(((("
		const {BrowserWindow} = require('electron');
		new BrowserWindow({
			height: " and:height) and:",
			width: ") and:width) and:"
		});"
	).
].

initializeWindow := [:mainWindow |
	">> Open the DevTools".
	(mainWindow subscriptGet:"webContents") openDevTools.
].