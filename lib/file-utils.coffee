remote = require "remote"
path   = require "path"
dialog = remote.require "dialog"

module.exports =
class FileUtil
  constructor: () ->
  @prepareFile: (buffer) ->
    if buffer.file? && buffer.file.existsSync
      FileUtil.saveIfModified(buffer)
    else
      FileUtil.saveNewFile(buffer)

  @getPngFilePath:(file) ->
    pngFileName = FileUtil.getPngFilename(file)
    filePath = file.path.split(path.sep)
    filePath.pop()
    filePath.join(path.sep) + path.sep + pngFileName

# private
  @saveIfModified:(buffer) ->
    if buffer.isModified()
      buffer.save()
    !buffer.isModified() # no longer modified when successfully saved

  @saveNewFile:(buffer) ->
    path = dialog.showSaveDialog(
      {options:{title:'save plantuml file'}})
    if path?
      buffer.setPath(path)
      buffer.save()
    !buffer.isModified() # no longer modified when successfully saved

  @getPngFilename:(file) ->
    fileName = path.basename(file.path)
    if fileName.indexOf('.') > -1
      unsuffixedFileName = fileName.split('.')
      unsuffixedFileName.pop()
      fileName = unsuffixedFileName.join('.')
    fileName + '.png'
