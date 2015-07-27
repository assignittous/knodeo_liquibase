# Knodeo Liquibase

This library is a wrapper for Liquibase's command line functionality.

For more info on Liquibase's command line instruction set:

http://www.liquibase.org/documentation/command_line.html

Important Note:

This library does *not* use `liquibase.properties`. 

Instead, it allows you to use a JSON object to allow greater control over execution. Whether you 
store this in your code or load it from a JSON, CSON, YAML or other type of data file is 
up to you.


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

# Prerequisites

* Liquibase installed and put in the path. If you can type in liquibase from a terminal or DOS window, you're probably good to go.

# Installation

To add it to your project:

`npm install knodeo-liquibase --save`

# Usage

Samples in coffeescript:

```

liquibase = require("liquibase").Liquibase

# note the parameters are case matched to the liquibase docs
options = 
  driver: "driver.name"
  classpath: "somepath"
  url: "url:1234/to/db"
  username: "username"
  password: "password"
  changeLogFile: "changelogfile/path"

diffOptions = 
  referenceUserName: "referenceUserName"
  referencePassword: "referencePassword"
  referenceUrl: "referenceUrl"
  referenceDriver: "referenceDriver(optional)"

# if this is set to true, the command will not be executed but shown in the console
# default is true
liquibase.testMode = false

# Sets the main runtime options for liquibase
liquibase.resetRunOptions options

# update
liquibase.update()
liquibase.updateCount 1
liquibase.updateSql()
liquibase.updateCountSql 1

# rollback
liquibase.rollback "tagName"
liquibase.rollbackCount 1

# generate changelog from an existing database, i.e., "reverse engineer"
liquibase.generateChangeLog()

# show the differences between the database specified in the options and the diffOptions
liquibase.diff diffOptions
liquibase.diffChangeLog diffOptions

# generate documentation on the currrent database
liquibase.dbDoc()

# tag the database
liquibase.tag "tagName"

# show the migration status of the database
liquibase.status()

# validate the liquibase changelog file
liquibase.validate()

# mark changes as "ran"
liquibase.changeLogSync()
liquibase.changeLogSyncSql()

# clear the options for running liquibase
liquibase.resetRunOptions()

```


