# PlantUml Integration

Atom package that provides a short cut (CMD+CTRL+P on Mac, CMD+ALT+P on Win) to call plantuml from any editor window that displays some text content. Uses saved content of Texteditor to generate not only a preview but also some linkable file. ExtOnly tested locally on a OSX so far.

## FAQ

### Question: Why can't Atom see my PlantUml Installation? I see it in terminal?

Answer: Did You Launch Atom Using The Shell Command?

The most common reason is that atom uses a different PATH than you see in terminal. In the version Atom uses PlantUml might not been included on OS X is due to the way OS X launches processes. When you launch Atom via processes created by launchd (e.g. using Finder, the Dock, or Spotlight) it likely will not have access to your $PATH if you set it in your shell initialization files (e.g. .bash_profile, .bashrc, .zshrc, etc).

Either launch Atom via your shell – using the Atom Shell Commands – then Atom should inherit your environment. Alternatively, try one of the suggestions at http://apple.stackexchange.com/a/87283 to set the PATH for processes launched by launchd (and their children, which will include Atom). An option to set plantuml explicitly
