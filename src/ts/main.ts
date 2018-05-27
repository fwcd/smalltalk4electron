import { BrowserWindow, app } from "electron";
import * as path from "path";
import { LOG, LogLevel, STBlock, STContext, STJSObject, STLoader, STMessageParameter, STObject, STString } from "smallballoon";

let stLoader = new STLoader();
let stContext = STContext.create();
stContext.setVariableLocally("appPath", new STString(path.join(__dirname, "../")));

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