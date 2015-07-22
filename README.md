# README

This library is a wrapper for Liquibase's command line.

http://www.liquibase.org/documentation/command_line.html

This library does *not* use `liquibase.properties`. 

It allows you to use a JSON object to allow greater control over execution. Whether you 
store this in your code or load it from a JSON, CSON, YAML or other type of data file is 
up to you.

# Prerequisites

* Liquibase installed and put in the path. If you can type in liquibase from a terminal or DOS window, you're probably good to go.

# Supported Command Line Tasks

Note that only the Liquibase CLI commands below are supported at this time.

* update
* updateCount <value>
* updateSQL
* updateCountSQL <value>
* rollback <tag>
* rollbackCount <value>
* generateChangelog
* diff
* diffChangelog
* dbDoc <output directory>
* tag <tag>
* status
* validate
* changelogSync
* changelogSyncSQL
* markNextChangeSetRan
* dropAll



  options:
    {
      driver: "driver.name.space"
      classPath: "path/to/driver"
      url: "database url"
      username: "username"
      password: "password"
      changeLogFile: "path/to/changelogfile"
      count: 1 # not all commands
      sql: true # not all commands
      execute:
        async: true
        test: true
    }