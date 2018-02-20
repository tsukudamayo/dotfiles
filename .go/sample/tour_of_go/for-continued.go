package main

import "fmt"

func main() {
    sum := 1
    for ; sum < 1000; {
        fmt.Println(sum)
        sum += sum
        fmt.Println(sum)
        sum *= sum
        fmt.Println(sum)
    }
    fmt.Println(sum)
}
