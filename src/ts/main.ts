import { BrowserWindow, app } from "electron";
import * as path from "path";
import { LOG, LogLevel, STBlock, STContext, STJSObject, STLoader, STMessageParameter, STObject, STString } from "smallballoon";

let mainWindow: Electron.BrowserWindow;
let stLoader = new STLoader();
let stContext = STContext.create();

LOG.level = LogLevel.Debug;

LOG.debug("Loading Smalltalk application...");
let stApp = stLoader.createASTFromFile("src/smalltalk/main.st");
LOG.debug("Running Smalltalk application...");
stApp.runWith(stContext);

function callSmalltalk(name: string, ...args: STMessageParameter[]): STObject {
	return stContext.getVariable(name).expect(STBlock).evaluateWith([], args);
}

function instantiateWindow(width: number, height: number): Electron.BrowserWindow {
	return new BrowserWindow({
		height: height,
		width: width
	});
}

function createWindow() {
	LOG.debug("Creating browser window through Smalltalk...");
	mainWindow = callSmalltalk("createBrowserWindow").expect(STJSObject).getObject();

	LOG.debug("Initializing browser window through Smalltalk...");
	callSmalltalk("initialize",
		{label: "mainWindow", value: new STJSObject(stContext, mainWindow)},
		{label: "appPath", value: new STString(path.join(__dirname, "../"))}
	);

	// Emitted when the window is closed.
	mainWindow.on("closed", () => {
		// Dereference the window object, usually you would store windows
		// in an array if your app supports multi windows, this is the time
		// when you should delete the corresponding element.
		mainWindow = null;
	});
}

app.on("ready", createWindow);
app.on("activate", () => {
	// On OS X it"s common to re-create a window in the app when the
	// dock icon is clicked and there are no other windows open.
	if (mainWindow === null) {
		createWindow();
	}
});