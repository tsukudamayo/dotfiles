package main

import "fmt"

func split(sum int) (x, y int) {
    x = sum * 4/9
    fmt.Println(x)
    y = sum - x
    fmt.Println(y)
    return
}

func main() {
    fmt.Println(split(17))
}
