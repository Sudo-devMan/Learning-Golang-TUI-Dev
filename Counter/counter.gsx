
package main

import (
  tui "github.com/grindlemire/go-tui"
  "fmt"
)

type counter struct {
    count *tui.State[int]
  }

func Counter() *counter {
    return &counter{
        count: tui.NewState(0),
      }
  }

func (c *counter) KeyMap() tui.KeyMap {
    return tui.KeyMap{
        tui.On(tui.KeyEscape, func(ke tui.KeyEvent) { ke.App().Stop() }),
        tui.On(tui.Rune('a'), func (ke tui.KeyEvent){ 
          c.count.Update(func(v int) int {return v + 1})
        }),
        tui.On(tui.Rune('d'), func(ke tui.KeyEvent){
            c.count.Update(func(v int) int {return v - 1})
          }),
        tui.On(tui.Rune('0'), func (ke tui.KeyEvent) {
            c.count.Update(func(v int) int {return v - v})
          }),
      }
  }

templ (c *counter) Render() {
    <div class="flex justify-center items-center h-full">
      <span class="font-bold text-cyan">{fmt.Sprintf("Count: %d", c.count.Get())}</span>
      <span class="text-dim">Press +/-/0 for count and q to quit</span>
    </div>
  }

