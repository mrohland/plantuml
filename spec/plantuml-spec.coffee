temp = require('temp').track()
fs = require "fs"
path = require "path"

Plantuml = require '../lib/plantuml'

describe "Plantuml", ->
  [workspaceElement, activationPromise, directory, editor, buffer] = []

  beforeEach ->
    directory = temp.mkdirSync()

    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('plantuml')

  describe "when no editor is open and plantuml:generate event is triggered", ->
    it "prints an warning if its called not inside some editor window", ->
      atom.commands.dispatch workspaceElement, 'plantuml:generate'

      waitsForPromise ->
        activationPromise

      runs ->
        warning = atom.notifications.getNotifications()[0]
        expect(warning).toBeDefined()
        expect(warning.type).toEqual("warning")

  describe "when editor is open and plantuml:generate event is triggered", ->

    beforeEach ->
      filePath = path.join(directory, 'plantuml.plantuml')
      fs.writeFileSync(filePath, '')

      waitsForPromise ->
        atom.workspace.open(filePath).then((e) ->
          editor = e
          buffer = editor.getBuffer()
          buffer.setText('@startuml\n(*) --> (*)\n@enduml')
        )


    it "saves the file if it is new", ->
      newFilePath = path.join(directory, "newPlantuml.plantuml")
      done = false
      atom.workspace.open(newFilePath).then((e) ->
        editor = e
        buffer = editor.getBuffer()
        buffer.setText('@startuml\n(*) --> (*)\n@enduml')
      )

      buffer.onDidSave((event)->
        done = true
      )

      atom.commands.dispatch workspaceElement, 'plantuml:generate'

      waitsForPromise ->
        activationPromise

      runs ->
        waitsFor ->
          done is true

    it "saves the file if it is modified", ->
      done = false

      buffer.onDidSave((event)->
        done = true
      )

      atom.commands.dispatch workspaceElement, 'plantuml:generate'

      waitsForPromise ->
        activationPromise

      runs ->
        waitsFor ->
          done is true

    it "opens a window to show the generated png", ->
      done = false

      atom.workspace.onDidOpen((event)->
        if event.uri.indexOf("plantuml.png") > -1
          done = true
        )
      atom.commands.dispatch workspaceElement, 'plantuml:generate'

      waitsForPromise ->
        activationPromise

      runs ->
        waitsFor ->
          done is true
