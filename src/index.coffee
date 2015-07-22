###

# Liquibase

This library is a wrapper for running scriptella.

###


aitutils = require("aitutils").aitutils
logger = aitutils.logger


shell = require('shelljs')

cwd = process.env.PWD || process.cwd()


exports.Liquibase = {

  ###
  options:
    {
      async: true
      test: true
    }
  ###
  execute: (command, options)->

    shellCommand = command.join(' ')

    logger.shell shellCommand
    if !options.test
      cmdoutput = shell.exec(shellCommand, {encoding: "utf8", silent: false, async: options.async || false})
      if cmdoutput.stdout?
        cmdoutput.stdout.on 'data', (data)->
          console.log data

  ###
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

  ###
  setOptions: (options)->

    command = ["liquibase"]

    command.push "--driver=#{options.driver}"
    command.push "--classpath=\"#{options.classPath.replace(/{{cwd}}/g,cwd)}\""
    command.push "--url=#{options.url}"
    command.push "--username=#{options.username}"
    command.push "--password=#{options.password}"
    command.push "--changeLogFile=#{options.changeLogFile}"

    return command



  update: (options)->
    
    #logger.info "Run migration for database named #{database} in #{environment} environment"
    if options.count?
      if typeof(options.count) == 'number'
        runCommand = "updateCount"
        commandParameter = options.count
      else
        options.count = null
    if options.sql?
      if options.sql
        runCommand = "updateSQL"
        if options.count?
          runCommand = "updateCountSQL"
          

    command = @setOptions(options)
    command.push runCommand      
    if commandParameter.length > 0
      command.push commandParameter
    #logger.todo "EXECUTE the migration using liquibase"
    @execute(command, options.execute)

  updateCount: (count, options)->

  updateSql: (options) ->

  updateCountSql: (count, options) ->




  rollback: (tag, options)->
    logger.info "Roll back migration"
    command = @setOptions(options)
    command.push "rollback"
    @execute(command, options.execute)

  rollbackCount: (count, options)->

  generateChangelog: (options)->
    logger.info "Reverse engineer the database named: "
    command = @setOptions(options)
    command.push "generateChangeLog"      
    @execute(command, options.execute)


  diff: (options)->

  diffChangeLog: (options)->

  dbDoc: (name)->
    logger.todo "Generate liquibase documentation for the database named: "


  tag: (tag)->
    logger.todo "Manually tag the database with '#{tag}'"

  status: (options)->
    command = @setOptions(options)
    command.push "status"
    @execute(command, options.execute)


  validate: (options)->
    logger.info "Validate a changeset file for the database named: "

    command = @setOptions(options)
    command.push "validate"      
    @execute(command, options.execute)


  changeLogSync: (name)->
    logger.todo "Mark all migrations as excuted in the database named "

  changeLogSyncSql: (name)->





  
}