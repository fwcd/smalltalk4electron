url := JS get:"require('url')".
path := JS get:"require('path')".
electron := JS get:"require('electron')".
LOG := JS get:"require('smallballoon').LOG".

app := electron getProperty:"app".
mainWindow := nil.

createBrowserWindow := [
	| width height |
	width := 800.
	height := 600.

	LOG debug:"Creating browser window".
	JS get:(((("
		const {BrowserWindow} = require('electron');
		new BrowserWindow({
			height: " and:height) and:",
			width: ") and:width) and:"
		});"
	).
].

initialize := [
	| mainHTML rawPath rawURL |
	LOG debug:"Initializing browser window".
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

createWindow := [
	mainWindow := createBrowserWindow value.
	initialize value.

	"Emitted when the window is closed.".
	mainWindow on:"closed" do:[
		"Dereference the window object, usually you would store windows
		in an array if your app supports multi windows, this is the time
		when you should delete the corresponding element.".
		mainWindow := nil.
	].
].

app on:"ready" do:[
	"This method will be called when Electron has finished
	initialization and is ready to create browser windows.
	Some APIs can only be used after this event occurs.".
	createWindow value.
	LOG debug:"Application is ready".
].

"Quit when all windows are closed.".
app on:"window-all-closed" do:[
	LOG debug:"Closed all windows".
	"On OS X it is common for applications and their menu bar
	to stay active until the user quits explicitly with Cmd + Q.".
	((JS eval:"process.platform") equals:"darwin") ifFalse:[
		LOG debug:"Quitting application".
		app quit.
	].
].

app on:"activate" do:[
	"On OS X it is common to re-create a window in the app when the
	dock icon is clicked and there are no other windows open.".
	(mainWindow isNil) ifTrue:[
		createWindow value.
	].
].