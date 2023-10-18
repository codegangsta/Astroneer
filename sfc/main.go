package main

import (
	"bytes"
	"flag"
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"syscall"

	"github.com/c-bata/go-prompt"
)

var suggestions = []prompt.Suggest{}
var serverAddr = "http://pc:55555"
var command string

func main() {
	flag.StringVar(&serverAddr, "server", serverAddr, "The address of the Starfield server")
	flag.StringVar(&serverAddr, "s", serverAddr, "The address of the Starfield server")

	flag.Parse()
	command = flag.Arg(0)

	if command != "" {
		executeCommand(command)
		return
	}

	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, os.Interrupt, syscall.SIGINT, syscall.SIGTERM)

	go func() {
		<-sigChan
		fmt.Println("\nCleaning up and exiting...")
		os.Exit(0)
	}()

	fillSuggestions()
	fmt.Printf("Connected to Starfield via %s\n", serverAddr)

	p := prompt.New(
		executeCommand,
		completer,
		prompt.OptionPrefix("> "),
	)

	p.Run()
}

func executeCommand(cmd string) {
	data := bytes.NewBufferString(cmd)
	resp, err := http.Post(serverAddr+"/console", "text/plain", data)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	buf := new(bytes.Buffer)
	buf.ReadFrom(resp.Body)
	fmt.Println(buf.String())
}

func fillSuggestions() {
	data := bytes.NewBufferString("ToggleFullHelp")
	http.Post(serverAddr+"/console", "text/plain", data)

	data = bytes.NewBufferString("help")
	resp, err := http.Post(serverAddr+"/console", "text/plain", data)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}

	buf := new(bytes.Buffer)
	buf.ReadFrom(resp.Body)

	// iterate over all the lines
	for _, line := range bytes.Split(buf.Bytes(), []byte("\n")) {
		// split the line into command and description
		split := bytes.Split(line, []byte(" -> "))
		if len(split) != 2 {
			continue
		}

		// add the command to suggestions
		suggestions = append(suggestions, prompt.Suggest{Text: string(split[0]), Description: string(split[1])})
	}

}

func completer(d prompt.Document) []prompt.Suggest {
	if d.TextBeforeCursor() == "" {
		return []prompt.Suggest{}
	}
	return prompt.FilterFuzzy(suggestions, d.GetWordBeforeCursor(), true)
}
