# Command line interfae

program = require "commander"
fs = require "fs-extra"

logger = require("knodeo-logger").Logger

pkg = require "./package.json" 

# Version
program
.version(pkg.version, "-v, --version")


# Clone template files to destination
.option('-c, --copy [destination]', 'Copy template items to target')





# Samples

config = program.command "config"
config.description "Create a new thing"
config.action ()->
  console.log "This command dumps the configuration"

# Subcommand support

subcommand = { }

subcommand.new = program.command "new"
subcommand.new.description "Create a new thing"
subcommand.new.option "-a, --parama [valuea]", "Some parameter"
subcommand.new.option "-b, --paramb [valueb]", "Another parameter"

subcommand.new.action ()->

  if subcommand.new.parama?
    logger.info "Do something"

  if subcommand.new.paramb?
    logger.info "Do something else"

# Parse the command

result = program.parse(process.argv)


if program.copy?
  console.log "Copy template files to #{program.copy}"

  fs.copySync "./.gitignore", "#{program.copy}.gitignore"
  fs.copySync "./package.json", "#{program.copy}package.json"
  fs.copySync "./README.md", "#{program.copy}README.md"
  fs.copySync "./gulpfile.coffee", "#{program.copy}gulpfile.coffee"


  fs.copySync "./src", "#{program.copy}src", {clobber: true}
