url := JS get:"require('url')".
path := JS get:"require('path')".
electron := JS get:"require('electron')".
app := electron getProperty:"app".
LOG := JS get:"require('smallballoon').LOG".

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

app on:"ready" do:[
	"This method will be called when Electron has finished
	initialization and is ready to create browser windows.
	Some APIs can only be used after this event occurs.".
	LOG debug:"Application is ready".
].

"Quit when all windows are closed.".
app on:"window-all-closed" do:[
	"On OS X it is common for applications and their menu bar
	to stay active until the user quits explicitly with Cmd + Q.".
	((JS eval:"process.platform") equals:"darwin") ifFalse:[
		app quit.
	].
].
