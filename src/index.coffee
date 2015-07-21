###

# Liquibase

This library is a wrapper for running scriptella.

###


aitutils = require("aitutils").aitutils
logger = aitutils.logger


shell = require('shelljs')

cwd = process.env.PWD || process.cwd()


exports.Liquibase = {


  execute: (command, async)->

    shellCommand = command.join(' ')
    logger.shell shellCommand
    #cmdoutput = shell.exec(shellCommand, {encoding: "utf8", silent: false, async: async || false})

    #if cmdoutput.stdout?
    #  cmdoutput.stdout.on 'data', (data)->
    #    console.log data

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

  status: (options)->
    command = @setOptions(options)
    command.push "status"
    @execute(command, true)



  run: (options)->
    
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
    @execute(command, true)



  rollback: (options)->

    logger.info "Roll back migration"
    command = @setOptions(options)
    command.push "rollback"
    @execute(command, true)

  tag: (tag)->
    logger.todo "Manually tag the database with '#{tag}'"

  validate: (options)->
    logger.info "Validate a changeset file for the database named: "

    command = @setOptions(options)
    command.push "validate"      
    @execute(command)

  doc: (name)->
    logger.todo "Generate liquibase documentation for the database named: "

  sync: (name)->
    logger.todo "Mark all migrations as excuted in the database named "

  reverseEngineer: (options)->

    logger.info "Reverse engineer the database named: "
    command = @setOptions(options)
    command.push "generateChangeLog"      
    @execute(command, true)


  reset: (name, environment)->
    logger.todo "Reset the database to tag 0.0.0"

  rebuild: (name, environment)->
    logger.todo "Run reset(), followed by migration.run()"
  
}