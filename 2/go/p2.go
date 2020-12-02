package main

import (
  "fmt"
  "io/ioutil"
  "os"
  "regexp"
  "strconv"
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
    count := 0

    p1,_ := strconv.Atoi(match[1])
    p2,_ := strconv.Atoi(match[2])
    letter := match[3]
    password := match[4]

    if string(password[p1 - 1]) == letter { count++ }
    if string(password[p2 - 1]) == letter { count++ }

    if count == 1 { validPasswords++ }
  }

  fmt.Printf("validPasswords: %v\n", validPasswords)
}
