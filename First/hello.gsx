
package main

import tui "github.com/grindlemire/go-tui"

type helloApp struct {}

// struct component
type myStructComponent struct {
    title string
    children []*tui.Element
  }

func NewStructComponent(title string, children []*tui.Element) *myStructComponent {
    return &myStructComponent{title: title, children: children}
  }

templ (m *myStructComponent) Render() {
    <div class="border-rounded p-1 flex-col gap-1 bg-yellow">
      <span class="font-bold text-magenta">{m.title}</span>
      {children...}
    </div>
  }

func Hello() *helloApp {
    return &helloApp{}
}

func (h *helloApp) KeyMap() tui.KeyMap {
    return tui.KeyMap{
        tui.On(tui.KeyEscape, func(ke tui.KeyEvent){ ke.App().Stop() }),
        tui.On(tui.Rune('q'), func(ke tui.KeyEvent){ ke.App().Stop() }),
      }
}

// Pure components that take in arguments
templ Greeting(name string) {
    <div class="text-green">{"Hello, " + name}</div>
  }

// working with children
templ Card(title string) {
    <div class="border-cyan m-2 p-3 gap-1">
      <span class="text-gradient-cyan-magenta font-bold">{title}</span>
      {children...}
    </div>
  }

templ (h *helloApp) Render() {
  <div class="h-full flex flex-col justify-center items-center">
    <span class="text-cyan font-bold">Hello World</span>
    @Greeting("Devman")
    @Greeting("Asynchronous")
    @Card("Sys shi") {
      <span class="text-blue">Fedora 44</span>
      <span>GNOME 50.4</span>
      }
    @NewStructComponent("New Struct") {
        <span>Towser</span>
        <span class="text-dim">We browser the web in the terminal nikka</span>
      }
    <br/>
    <span class="font-dim">Type q to exit bruhhhh</span>
  </div>
}

