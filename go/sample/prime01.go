package main

import (
    "fmt"
    "time"
)

func main() {
    max := 100
    fmt.Printf("%v 以下の素数:", max)

    start := time.Now()
    for n := 2; n <= max; n++ {
        flag := true
        for m := 2; m < n; m++ {
            if (n % m) == 0 {
                flag = false
                break
            }
        }
        if flag {
            fmt.Printf(" %v", n)
        }
    }
    goal := time.Now()
    fmt.Printf("\n%v 経過", goal.Sub(start))
}
