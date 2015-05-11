{BufferedProcess} = require 'atom'
fs = require 'fs-plus'

module.exports =
class PlantUml
  constructor: () ->
  @writeAndOpenPng:(umlFilePath, pngFilePath) ->
    command = 'plantuml'
    args = ['-failfast2', umlFilePath]
    exit = (code) ->
      if PlantUml.isRegeneratedPng(pngFilePath, startTime)
        atom.workspace.open(pngFilePath, {
          split: 'right'
          activatePane: false
        })
      else
        atom.notifications.addWarning('PlantUml could not generate file.', {
          detail:'Please make sure PlantUml can write
           to location of original file.'})

    startTime = Date.now()
    new BufferedProcess({command, args, exit})

  @isRegeneratedPng:(pngFilePath, startTime) ->
    fs.isFileSync(pngFilePath) and fs.statSync(pngFilePath).mtime > startTime
