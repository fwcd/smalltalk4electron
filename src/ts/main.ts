import * as path from "path";
import { LOG, LogLevel, STContext, STLoader, STString } from "smallballoon";

LOG.level = LogLevel.Debug;

let stContext = STContext.create();
stContext.setVariableLocally("appPath", new STString(path.join(__dirname, "../")));
LOG.debug("Loading Smalltalk application...");
let stApp = new STLoader().createASTFromFile("src/smalltalk/main.st");
LOG.debug("Running Smalltalk application...");
stApp.runWith(stContext);