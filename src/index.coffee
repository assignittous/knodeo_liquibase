###

# Liquibase

This library is a wrapper for running scriptella.

###

_ = require "lodash"

aitutils = require("aitutils").aitutils
logger = aitutils.logger


shell = require('shelljs')

cwd = process.env.PWD || process.cwd()


exports.Liquibase = {

  testMode: false # When true, the commands are output to the console
  options: {}


  # Apply options to the liquibase (similar to using liqubase.properties)
  # If the options parameter is omitted, it clears the attribute
  resetRunOptions: (options)->
    if options?
      @options = options
    else
      @options = {}

  # Convert an object into a properly formatted parameter string:
  # --key=value
  # An exception exists for the changeLogFile in that it surrounds it with double quotes
  parameterize: (options)->

    parameters = ""
    _.forIn options, (value, key)->
      if (key == "changeLogFile") || (key == "classpath")  # in case paths have spaces
        value = "\"#{value}\""
      parameters += "--#{key}=#{value} "


    return parameters


  execute: (command, options)->


    logger.shell command
    if !@testMode
      cmdoutput = shell.exec(command, {encoding: "utf8", silent: false, async: false })
      if cmdoutput.stdout?
        cmdoutput.stdout.on 'data', (data)->
          console.log data
          exit(1)

  buildCommand: (command, parameters)->


    tailParameters = ""
    runParameters = @options

    if parameters?
      if parameters instanceof Object
        console.log "enumerate parameters"
        runParameters = _.merge runParameters, parameters
      else
        if isNaN(parameters)
          tailParameters = "\"#{parameters}\""
        else
          tailParameters = parameters
    #return commandStack
    
    runParameters = @parameterize(runParameters)

    return "liquibase #{runParameters} #{command} #{tailParameters}"



  update: ()->
    @execute @buildCommand("update")

  updateCount: (count)->
    @execute @buildCommand("updateCount", count)

  updateSql: () ->
    @execute @buildCommand("updateSQL")

  updateCountSql: (count) ->
    @execute @buildCommand("updateCountSQL", count)

  rollback: (tag)->
    @execute @buildCommand("rollback", tag)

  rollbackCount: (count)->
    @execute @buildCommand("rollbackCount", count)


  generateChangeLog: ()->
    @execute @buildCommand("generateChangeLog")


  ###
  
  Diff parameters

  --referenceUsername
  --referencePassword
  --referenceUrl

  ###

  diff: (options)->
    @execute @buildCommand("diff", options)


  diffChangeLog: (options)->
    @execute @buildCommand("diffChangeLog", options)


  dbDoc: (name)->
    @execute @buildCommand("dbDoc", name)


  tag: (tag)->
    @execute @buildCommand("tag", tag)

  status: ()->
    @execute @buildCommand("status")

  validate: ()->
    @execute @buildCommand("validate")

  changeLogSync: ()->
    @execute @buildCommand("changelogSync")

  changeLogSyncSql: ()->
    @execute @buildCommand("changelogSyncSQL")





  
}