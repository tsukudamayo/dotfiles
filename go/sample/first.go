package main

import (
    "fmt"
)

// variable
//var message string = "Hello world!"

// multiple declarations and initialization of variable
var (
    a string = "aaa"
    b = "bbb"
    c = "ccc"
    d = "ddd"
    e = "eee"
)

// struct
type Task struct {
    ID int
    Detail string
    done bool
}

func main() {
    // same
    //var message string = "Hello world!"
    message := "Hello world!"
    const Hello string = "hello"
    // error : cannot assign to Hello
    //Hello = "bye"
    fmt.Println(message)


    // if you declare without explicity initalizing the value,
    // 0 is assigned to the variable
    var i int
    fmt.Println(i)  // 0


    // if statement
    a, b := 10, 100
    if a > b {
        fmt.Println(" a is larger than b\n")
    } else if a < b {
        fmt.Println(" a is smaller than b\n")
    } else {
        fmt.Println(" a equals b\n")
    }


    // for statement
    n := 0
    for n < 10 {
        fmt.Printf("n = %d\n", n)
        n++
    }


    // while-break statement
    m := 0
    for {
        m++
        if m > 20 {
            fmt.Printf("break\n\n")
            break // break loop
        }
        if m % 2 == 0 {
            fmt.Printf("continue\n")
            continue  // if n is even number, go to next loop
        }
        fmt.Printf("m  = %d\n", m) // print only odd number
    }

    // struct
    var task Task = Task {
        ID: 1,
        Detail: "buy the milk",
        done: true,
    }

    fmt.Println("task.ID")
    fmt.Println(task.ID)
    fmt.Println("task.Detail")
    fmt.Println(task.Detail)
    fmt.Println("task.done")
    fmt.Println(task.done)
    fmt.Println("\n")


    // pointer
//    task := Task{done: false}
//    Finish1(task)
//    fmt.Println(task.done)  // falseのまま
//
//    task := &Task{done: false}
//    Finish2(task)
//    fmt.Println(task.done) // true

}


//func Finish1(task Task) {
//    task.done = true
//}
//
//func Finish2(task *Task) {
//    task.done = true
//}





