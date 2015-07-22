var liquibase, options;

console.log("TEST");

liquibase = require("./index").Liquibase;

options = {
  driver: "driver.name",
  classPath: "somepath",
  url: "url:1234/to/db",
  username: "username",
  password: "password",
  changeLogFile: "changelogfile/path",
  count: 1,
  sql: true,
  execute: {
    async: true,
    test: false
  }
};

liquibase.status(options);

liquibase.run(options);

liquibase.rollback(options);

liquibase.validate(options);

liquibase.reverseEngineer(options);
