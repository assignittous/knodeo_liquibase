var diffOptions, liquibase, options;

console.log("TEST");

liquibase = require("./index").Liquibase;

options = {
  driver: "driver.name",
  classpath: "somepath",
  url: "url:1234/to/db",
  username: "username",
  password: "password",
  changeLogFile: "changelogfile/path"
};

diffOptions = {
  referenceUserName: "referenceUserName",
  referencePassword: "referencePassword",
  referenceUrl: "referenceUrl",
  referenceDriver: "referenceDriver(optional)"
};

console.log(liquibase.parameterize(diffOptions));

liquibase.testMode = false;

liquibase.resetRunOptions(options);

liquibase.update();

liquibase.updateCount(1);

liquibase.updateSql();

liquibase.updateCountSql(1);

liquibase.rollback("tagName");

liquibase.rollbackCount(1);

liquibase.generateChangeLog();

liquibase.diff(diffOptions);

liquibase.diffChangeLog(diffOptions);

liquibase.dbDoc();

liquibase.tag("tagName");

liquibase.status(options);

liquibase.validate();

liquibase.changeLogSync(options);

liquibase.changeLogSyncSql(options);

liquibase.resetRunOptions();
