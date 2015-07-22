
/*

 * Liquibase

This library is a wrapper for running scriptella.
 */
var _, aitutils, cwd, logger, shell;

_ = require("lodash");

aitutils = require("aitutils").aitutils;

logger = aitutils.logger;

shell = require('shelljs');

cwd = process.env.PWD || process.cwd();

exports.Liquibase = {
  testMode: false,
  options: {},
  resetRunOptions: function(options) {
    if (options != null) {
      return this.options = options;
    } else {
      return this.options = {};
    }
  },
  parameterize: function(options) {
    var parameters;
    parameters = "";
    _.forIn(options, function(value, key) {
      if ((key === "changeLogFile") || (key === "classpath")) {
        value = "\"" + value + "\"";
      }
      return parameters += "--" + key + "=" + value + " ";
    });
    return parameters;
  },
  execute: function(command, options) {
    var cmdoutput;
    logger.shell(command);
    if (!this.testMode) {
      cmdoutput = shell.exec(command, {
        encoding: "utf8",
        silent: false,
        async: false
      });
      if (cmdoutput.stdout != null) {
        return cmdoutput.stdout.on('data', function(data) {
          console.log(data);
          return exit(1);
        });
      }
    }
  },
  buildCommand: function(command, parameters) {
    var runParameters, tailParameters;
    tailParameters = "";
    runParameters = this.options;
    if (parameters != null) {
      if (parameters instanceof Object) {
        console.log("enumerate parameters");
        runParameters = _.merge(runParameters, parameters);
      } else {
        if (isNaN(parameters)) {
          tailParameters = "\"" + parameters + "\"";
        } else {
          tailParameters = parameters;
        }
      }
    }
    runParameters = this.parameterize(runParameters);
    return "liquibase " + runParameters + " " + command + " " + tailParameters;
  },
  update: function() {
    return this.execute(this.buildCommand("update"));
  },
  updateCount: function(count) {
    return this.execute(this.buildCommand("updateCount", count));
  },
  updateSql: function() {
    return this.execute(this.buildCommand("updateSQL"));
  },
  updateCountSql: function(count) {
    return this.execute(this.buildCommand("updateCountSQL", count));
  },
  rollback: function(tag) {
    return this.execute(this.buildCommand("rollback", tag));
  },
  rollbackCount: function(count) {
    return this.execute(this.buildCommand("rollbackCount", count));
  },
  generateChangeLog: function() {
    return this.execute(this.buildCommand("generateChangeLog"));
  },

  /*
  
  Diff parameters
  
  --referenceUsername
  --referencePassword
  --referenceUrl
   */
  diff: function(options) {
    return this.execute(this.buildCommand("diff", options));
  },
  diffChangeLog: function(options) {
    return this.execute(this.buildCommand("diffChangeLog", options));
  },
  dbDoc: function(name) {
    return this.execute(this.buildCommand("dbDoc", name));
  },
  tag: function(tag) {
    return this.execute(this.buildCommand("tag", tag));
  },
  status: function() {
    return this.execute(this.buildCommand("status"));
  },
  validate: function() {
    return this.execute(this.buildCommand("validate"));
  },
  changeLogSync: function() {
    return this.execute(this.buildCommand("changelogSync"));
  },
  changeLogSyncSql: function() {
    return this.execute(this.buildCommand("changelogSyncSQL"));
  }
};
