package main

import "fmt"

func main() {
    ch := make(chan int, 10000000000000000000)
    ch <- 1
    ch <- 2
    fmt.Println(<-ch)
    fmt.Println(<-ch)
}
