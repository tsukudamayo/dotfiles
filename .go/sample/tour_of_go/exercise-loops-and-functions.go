package main

import (
    "fmt"
)

func Sqrt(x float64) float64 {
    a := 5.0
    for i:=0; i<10; i++ {
        a -= a-(a*a-2)/(a*2)
        fmt.Println(a)
    }
    return a
}

func main() {
    fmt.Println(Sqrt(2))
}
