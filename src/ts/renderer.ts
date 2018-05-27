import * as path from "path";
import { STContext, STString, LOG, STLoader, LogLevel } from "smallballoon/build/main/ts";

let stContext = STContext.create();
stContext.setVariableLocally("appPath", new STString(path.join(__dirname, "../")));
let stApp = new STLoader().createASTFromFile("src/smalltalk/renderer.st");
stApp.runWith(stContext);