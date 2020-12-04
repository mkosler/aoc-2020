package main

import (
  "fmt"
  "bufio"
  "os"
)

type Vertex struct {
  R, C int
}

func main() {
  var routeMap [][]bool

  scanner := bufio.NewScanner(os.Stdin)

  for scanner.Scan() {
    var row []bool

    for _,c := range scanner.Text() {
      row = append(row, c == '#')
    }

    routeMap = append(routeMap, row)
  }

  width := len(routeMap[0])
  height := len(routeMap)

  pos := Vertex{0, 0}
  velocity := Vertex{1, 3}
  treeCount := 0

  for pos.R < height {
    pos.R += velocity.R
    pos.C = (pos.C + velocity.C) % width

    if pos.R >= height {
      break
    }

    if routeMap[pos.R][pos.C] {
      treeCount++
    }
  }

  fmt.Printf("treeCount: %v\n", treeCount)
}
