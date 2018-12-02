package main

import (
    "fmt"
    "math"
)

type Abser interface {
    Abs() float64
}

func main() {
    var a Abser
    f := MyFloat(-math.Sqrt2)
    v := Vertex{3, 4}

    a = f   // a MyFloat implements Abser
    a = &v  // a *Vertex implements Abser

    // In the fllowing line, v is a Vertex ( not *Vertex )
    // and does NOT implement Abser
    a = v

    fmt.Println(a.Abs())
}

type MyFloat float64

func (f MyFloat) Abs() float64 {

}
