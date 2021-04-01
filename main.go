package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	// "io/ioutil"
)

type intent struct {
	DisplayName string `json:"displayName"`
}

type queryResult struct {
	Intent intent `json:"intent"`
}

type text struct {
	Text []string `json:"text"`
}

type suggestions struct{
Suggestions []string `json:"suggestions"`
}
type message struct {
	Text    text    `json:"text"`

}


type webhookRequest struct {
	Session     string      `json:"session"`
	ResponseID  string      `json:"responseId"`
	QueryResult queryResult `json:"queryResult"`
}


type webhookResponse struct {
	FulfillmentText string `json:"fulfillmentText"`
	FulfillmentMessages []message `json:"fulfillmentMessages"`

}

type payload struct {
	Suggestions []string `json:"suggestions"`
	Func        []string `json:"func"`
	Display     []string `json:"display"`
	Multiple    []string `json:"multiple"`
	Rows        int      `json:"rows"`
	Implicit    []string `json:"implicit"`
}
 
 
type motivation struct {
	Q string `json:"q"`
	A string `json:"a"`
	H string `json:"h"`
}



func motivate(request webhookRequest) (webhookResponse, error) {
	
resp, err := http.Get("https://zenquotes.io/api/random")

if(err!=nil){
	fmt.Printf(err.Error())
}
var p []motivation
err = json.NewDecoder(resp.Body).Decode(&p)
if(err!=nil){
	fmt.Printf(err.Error())
}

quote:=fmt.Sprintf("%s",p[0].Q)
author:= fmt.Sprintf("%s",p[0].A)
finalQuote := quote + " - " + author
	response := webhookResponse{
		FulfillmentMessages: []message{
			{
				Text: text{
					Text: []string{finalQuote},
				},
			},
		},
	}
	return response, nil
}

func getAgentName(request webhookRequest) (webhookResponse, error) {
	response := webhookResponse{
		FulfillmentMessages: []message{
			{
				Text: text{
					Text: []string{"My name is Dialogflow Go Webhook"},
				},
			},
		},
	}
	return response, nil
}


func handleError(w http.ResponseWriter, err error) {
	w.WriteHeader(http.StatusInternalServerError)
	fmt.Fprintf(w, "ERROR: %v", err)
}

func SOShotline(request webhookRequest) (webhookResponse, error) {

	str:=fmt.Sprintf("%s Is the number u can call for help","2233234")
	response := webhookResponse{
	
		FulfillmentText: 	str,
		FulfillmentMessages: []message{
			{
				Text: text{
					Text: []string{"Dummy text"},
				},
			
			},
		
		},
			
	}

	return response, nil
}


func HandleWebhookRequest(w http.ResponseWriter, r *http.Request) {
	var request webhookRequest
	var response webhookResponse
	var err error

	ua := r.Header.Get("Authorization")
	if ua == "Basic YXNrc3R1ZGlvOm1hTlZXQ0ZTWGpjTjZoRw==" {
		log.Println("LOgged in")
	}


	if err = json.NewDecoder(r.Body).Decode(&request); err != nil {
		handleError(w, err)
		return
	}
	log.Printf("Request: %+v", request)


	switch intent := request.QueryResult.Intent.DisplayName; intent {
	case "motivate me":
		response, err = motivate(request)
	case "get-agent-name":
		response, err = getAgentName(request)
	case "SOS":
		response, err = SOShotline(request)
	default:
		err = fmt.Errorf("Unknown intent: %s", intent)
	}
	if err != nil {
		handleError(w, err)
		return
	}
	log.Printf("Response: %+v", response)


	if err = json.NewEncoder(w).Encode(&response); err != nil {
		handleError(w, err)
		return
	}
}

func main() {
	http.HandleFunc("/welcome", HandleWebhookRequest)
	http.ListenAndServe(":8000", nil)
}
