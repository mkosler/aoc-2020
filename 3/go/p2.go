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

  velocities := []Vertex{
    Vertex{1, 1},
    Vertex{1, 3},
    Vertex{1, 5},
    Vertex{1, 7},
    Vertex{2, 1},
  }

  answer := 1

  for _,velocity := range velocities {
    pos := Vertex{0, 0}
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

    answer *= treeCount
  }

  fmt.Printf("answer: %v\n", answer)
}
