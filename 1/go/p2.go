package main

import (
  "fmt"
  "bufio"
  "os"
  "strconv"
)

func main() {
  var expenses []int
  scanner := bufio.NewScanner(os.Stdin)
  
  for scanner.Scan() {
    i,_ := strconv.Atoi(scanner.Text())
    expenses = append(expenses, i)
  }

  for _,a := range expenses {
    for _,b := range expenses {
      for _,c := range expenses {
        if a != b && a != c && b != c && a + b + c == 2020 {
          fmt.Printf("%v %v %v %v\n", a, b, c, a * b * c)
          return
        }
      }
    }
  }
}
