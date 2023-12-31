# AoC2023-Elixir

My Advent of Code 2023 solutions, through which I learned programming in Elixir. Not sure what Advent of Code is? Check it out on the official website! [https://adventofcode.com/](https://adventofcode.com/)

### Why Elixir?

In terms of other languages I've learned, Elixir is like a fusion between Python and Haskell. I went from being frustrated at the lack of typing to being amazed at the Pythonic levels of flexibility. Elixir also has the advantage of being backwards-compatible with Erlang, as Kotlin is to Java, so there is a massive standard library you can access. 

There are many more reasons to program with Elixir in 2023 too, such as the concurrency-oriented *supervision trees* that give rise to robust, scalable cooperative multithreading (coroutine) patterns, and the fact that Elixir runs in a VM, making it portable by default without the need for Docker/Singularity containers.

## Installation

Run the following command to install dependencies:
```bash
mix do deps.get, deps.compile
```

This repository uses Nimble Parsec as its parsing library, but otherwise primarily relies on the standard libraries of Elixir and Erlang

To run the code, use the following command:
```bash
mix run
```
This will generate an executable app

