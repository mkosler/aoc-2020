package main

import (
  "fmt"
  "io/ioutil"
  "os"
  "regexp"
  "strconv"
  "strings"
)

func main() {
  validPasswords := 0

  bytes, err := ioutil.ReadAll(os.Stdin)
  if err != nil {
    fmt.Println(err)
  }

  file := string(bytes)

  pattern := regexp.MustCompile(`(\d+)-(\d+)\s+(\w):\s+(\w+)`)

  for _,match := range pattern.FindAllStringSubmatch(file, -1) {
    min,_ := strconv.Atoi(match[1])
    max,_ := strconv.Atoi(match[2])
    letter := match[3]
    password := match[4]

    count := strings.Count(password, letter)

    if min <= count && count <= max {
      validPasswords++
    }
  }

  fmt.Printf("validPasswords: %v\n", validPasswords)
}
