package main

import (
	"log"
	"runtime"

	"github.com/codegangsta/astroneering/exchange"
	"github.com/nats-io/nats.go"
	"github.com/nats-io/nats.go/micro"
)

func main() {
	e := exchange.New("Test Exchange")
	e.Categories = categories()
	e.Companies = companies(e)

	nc, err := nats.Connect(nats.DefaultURL)
	if err != nil {
		log.Fatal(err)
	}

	service, err := micro.AddService(nc, micro.Config{
		Name:        "astroneering",
		Description: "Astroneering is a galactic stock exchange simulator for Starfield.",
		Version:     "0.0.1",
	})
	if err != nil {
		log.Fatal(err)
	}

	service.AddEndpoint("get_exchange", micro.HandlerFunc(func(r micro.Request) {
		r.RespondJSON(e)
	}), micro.WithEndpointSubject("astroneering.get_exchange"))

	service.AddEndpoint("next_quarter", micro.HandlerFunc(func(r micro.Request) {
		err := e.TickQuarter()
		if err != nil {
			// TODO: Handle error better
			r.Error("internal_error", err.Error(), nil)
		}
		r.RespondJSON(e)
	}), micro.WithEndpointSubject("astroneering.next_quarter"))

	service.AddEndpoint("next_day", micro.HandlerFunc(func(r micro.Request) {
		err := e.TickDay()
		if err != nil {
			// TODO: Handle error better
			r.Error("internal_error", err.Error(), nil)
		}
		r.RespondJSON(e)
	}), micro.WithEndpointSubject("astroneering.next_day"))

	e.TickQuarter()

	runtime.Goexit()
}
