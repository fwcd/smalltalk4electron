var path = require("path");
var sb = require("smallballoon");

var stContext = sb.STContext.create();
stContext.setVariableLocally("appPath", new sb.STString(path.join(__dirname, "../../")));
var stApp = new sb.STLoader().createASTFromFile("src/smalltalk/renderer.st");
stApp.runWith(stContext);