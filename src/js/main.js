var path = require("path");
var sb = require("smallballoon");

sb.LOG.level = sb.LogLevel.Debug;

var stContext = sb.STContext.create();
stContext.setVariableLocally("appPath", new sb.STString(path.join(__dirname, "../../")));
sb.LOG.debug("Loading Smalltalk application...");
var stApp = new sb.STLoader().createASTFromFile("src/smalltalk/main.st");
sb.LOG.debug("Running Smalltalk application...");
stApp.runWith(stContext);