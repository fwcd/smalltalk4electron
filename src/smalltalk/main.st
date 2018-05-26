url := JS get:"require('url')".
path := JS get:"require('path')".

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

initialize := [:mainWindow :appPath |
	| mainHTML rawPath rawURL |
	mainHTML := "index.html".

	rawPath := path join:appPath and:mainHTML.
	rawURL := JS get:"new Object()".
	rawURL setProperty:"pathname" to:rawPath.
	rawURL setProperty:"protocol" to:"file:".
	rawURL setProperty:"slashes" to:true.

	">> Load web page".
	mainWindow loadURL:(url format:rawURL).

	">> Open the DevTools".
	(mainWindow getProperty:"webContents") openDevTools.
].