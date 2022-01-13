---
title: CardSync Universal Account Updater
language_tabs:
  - shell: Shell
  - http: HTTP
  - javascript: JavaScript
  - ruby: Ruby
  - python: Python
  - php: PHP
  - java: Java
  - go: Go
toc_footers: []
includes: []
search: false
highlight_theme: darkula
headingLevel: 2

---

<!-- Generator: Widdershins v4.0.1 -->

<h1 id="cardsync-universal-account-updater">CardSync American Express Account Updater</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

# Introduction

This is the API for the CardSync American Express Account Updater service.

After signing up as a CardSync Partner, you will be able to use this API in sandbox and production. You will be provided with an API key and a Partner Billing Identifier.

This API allows Partners to enroll American Express cards in subscriptions for future updates.

Here are the set of steps needed to enroll a merchant and obtain card number updates:

1. Set up webhook to be called when card updates are available.
2. Submit a subscription request of American Express cards via the /v2/subscribe POST. 
3. When an update for one or more of those cards is available, a webhook will be called with an "event_id".
4. Retrieve the results via /v2/subscription/results?event_id={EVENT_ID}.

Each subscribe request may consist of up to 10,000 card numbers. There is no limit on the number of consecutive batch submissions. Inquiries may return one of six responses: updated_card, updated_expiry, no_match, valid, contact, or contact_closed. If the response is updated_card or updated_expiry, the updated card information is returned. Otherwise, one of the other four status types is returned. Some card inquiries do not result in any status type. This generally means the card is valid.

For more information, visit <a href="https://cardsync.io">https://cardsync.io</a>.

Contact Support:  
    Email: help@cardsync.io

This document describes the CardSync American Express Account Updater. For the multi-brand API service, please visit <a href="https://api.cardsync.io/index.html">https://api.cardsync.io/index.html</a>.

Base URLs:

* <a href="https://sandbox.cardsync.io/">https://sandbox.cardsync.io/</a>

# Authentication

* API Key (Authorization)
  - Parameter Name: **Authorization**, in: header.

# Webhooks

## Set Up Webhook

`POST /v2/webhook`

This endpoint is used to set up the webhook that is called when an American Express card update is available.

> Body parameter

```json
{
  "trigger_id": 23, 
  "url": "amex_update_url"
}
```

<h3 id="add-webhooks-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[Webhook](#schemawebhooks)|true|none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

<a id="opIdSetupwebhook"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/v2/webhook \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/v2/webhook HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "trigger_id": 23, 
  "url": "amex_update_url"
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/webhook',
{
  method: 'POST',
  body: inputBody,
  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

```ruby
require 'rest-client'
require 'json'

headers = {
  'Content-Type' => 'application/json',
  'Accept' => 'application/json',
  'Authorization' => 'API_KEY'
}

result = RestClient.post 'https://sandbox.cardsync.io/v2/webhook',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'API_KEY'
}

r = requests.post('https://sandbox.cardsync.io/v2/webhook', headers = headers)

print(r.json())

```

```php
<?php

require 'vendor/autoload.php';

$headers = array(
    'Content-Type' => 'application/json',
    'Accept' => 'application/json',
    'Authorization' => 'API_KEY',
);

$client = new \GuzzleHttp\Client();

// Define array of request body.
$request_body = array();

try {
    $response = $client->request('POST','https://sandbox.cardsync.io/v2/webhook', array(
        'headers' => $headers,
        'json' => $request_body,
       )
    );
    print_r($response->getBody()->getContents());
 }
 catch (\GuzzleHttp\Exception\BadResponseException $e) {
    // handle exception or api errors.
    print_r($e->getMessage());
 }

 // ...
```

```java
URL obj = new URL("https://sandbox.cardsync.io/v2/webhook");
HttpURLConnection con = (HttpURLConnection) obj.openConnection();
con.setRequestMethod("POST");
int responseCode = con.getResponseCode();
BufferedReader in = new BufferedReader(
    new InputStreamReader(con.getInputStream()));
String inputLine;
StringBuffer response = new StringBuffer();
while ((inputLine = in.readLine()) != null) {
    response.append(inputLine);
}
in.close();
System.out.println(response.toString());

```

```go
package main

import (
       "bytes"
       "net/http"
)

func main() {

    headers := map[string][]string{
        "Content-Type": []string{"application/json"},
        "Accept": []string{"application/json"},
        "Authorization": []string{"API_KEY"},
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/v2/webhook", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}
```

> Example responses
> 200 Response

```json
{
  "status": "success",
  "msg": "success"
}
```

<h3 id="webhook-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Generic Response](#schemagenericresponse)|

# Card Updates

A subscription is a request for ongoing updates for an enrolled card. Once a card is enrolled for updates by submitting a card number, expiration date, and SE number, any future updates to that card will result in the webhook being called.

## Create American Express Card Subscription

<a id="opIdCreatesbatchofcardsforsubscriptions"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/v2/subscribe \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/v2/subscribe HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "cards": [
    {
      "se_number": "amex se number",
      "id": "customer identifier",
      "card": "342132335566772",
      "exp": "12/24"
    },
    {
      "se_number": "amex se number",
      "id": "customer identifier",
      "card": "376655111122997",
      "exp": "12/24"
    },
    {
      "se_number": "amex se number",
      "id": "customer identifier",
      "card": "349900006577234",
      "exp": "12/24"
    }
  ]
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/subscribe',
{
  method: 'POST',
  body: inputBody,
  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

```ruby
require 'rest-client'
require 'json'

headers = {
  'Content-Type' => 'application/json',
  'Accept' => 'application/json',
  'Authorization' => 'API_KEY'
}

result = RestClient.post 'https://sandbox.cardsync.io/v2/subscribe',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'API_KEY'
}

r = requests.post('https://sandbox.cardsync.io/v2/subscribe', headers = headers)

print(r.json())

```

```php
<?php

require 'vendor/autoload.php';

$headers = array(
    'Content-Type' => 'application/json',
    'Accept' => 'application/json',
    'Authorization' => 'API_KEY',
);

$client = new \GuzzleHttp\Client();

// Define array of request body.
$request_body = array();

try {
    $response = $client->request('POST','https://sandbox.cardsync.io/v2/subscribe', array(
        'headers' => $headers,
        'json' => $request_body,
       )
    );
    print_r($response->getBody()->getContents());
 }
 catch (\GuzzleHttp\Exception\BadResponseException $e) {
    // handle exception or api errors.
    print_r($e->getMessage());
 }

 // ...

```

```java
URL obj = new URL("https://sandbox.cardsync.io/v2/subscribe");
HttpURLConnection con = (HttpURLConnection) obj.openConnection();
con.setRequestMethod("POST");
int responseCode = con.getResponseCode();
BufferedReader in = new BufferedReader(
    new InputStreamReader(con.getInputStream()));
String inputLine;
StringBuffer response = new StringBuffer();
while ((inputLine = in.readLine()) != null) {
    response.append(inputLine);
}
in.close();
System.out.println(response.toString());

```

```go
package main

import (
       "bytes"
       "net/http"
)

func main() {

    headers := map[string][]string{
        "Content-Type": []string{"application/json"},
        "Accept": []string{"application/json"},
        "Authorization": []string{"API_KEY"},
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/v2/subscribe", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`POST /v2/subscribe`

This endpoint creates subscriptions for batches of American Express cards.

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

## American Express Test Data (Sandbox only)

You can supply any Luhn10 valid card number, but to trigger specific responses, please use the following test card numbers in the sandbox environment.

### American Express Test Cards

342132335566772 - updated_card  
376655111122997 - updated_expiry  
349900006577234 - contact_closed  

> Body parameter

```json
{
  "cards": [
    {
      "se_number": "1234567890",
      "id": "customer identifier",
      "card": "342132335566772",
      "exp": "12/24"
    },
    {
      "se_number": "1234567890",
      "id": "customer identifier",
      "card": "376655111122997",
      "exp": "12/24"
    },
    {
      "se_number": "1234567890",
      "id": "customer identifier",
      "card": "349900006577234",
      "exp": "12/24"
    }
  ]
}
```

## Retrieve Subscription Results

<a id="opIdRetrievesubscriptionresults"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://sandbox.cardsync.io/v2/subscription/results?event_id={EVENT_ID} \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/v2/subscription/results?event_id={EVENT_ID} HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/subscription/results?event_id={EVENT_ID}',
{
  method: 'GET',

  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

```ruby
require 'rest-client'
require 'json'

headers = {
  'Accept' => 'application/json',
  'Authorization' => 'API_KEY'
}

result = RestClient.get 'https://sandbox.cardsync.io/v2/subscription/results?event_id={EVENT_ID}',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Accept': 'application/json',
  'Authorization': 'API_KEY'
}

r = requests.get('https://sandbox.cardsync.io/v2/subscription/results?event_id={EVENT_ID}', headers = headers)

print(r.json())

```

```php
<?php

require 'vendor/autoload.php';

$headers = array(
    'Accept' => 'application/json',
    'Authorization' => 'API_KEY',
);

$client = new \GuzzleHttp\Client();

// Define array of request body.
$request_body = array();

try {
    $response = $client->request('GET','https://sandbox.cardsync.io/v2/subscription/results?event_id={EVENT_ID}', array(
        'headers' => $headers,
        'json' => $request_body,
       )
    );
    print_r($response->getBody()->getContents());
 }
 catch (\GuzzleHttp\Exception\BadResponseException $e) {
    // handle exception or api errors.
    print_r($e->getMessage());
 }

 // ...

```

```java
URL obj = new URL("https://sandbox.cardsync.io/v2/subscription/results?event_id={EVENT_ID}");
HttpURLConnection con = (HttpURLConnection) obj.openConnection();
con.setRequestMethod("GET");
int responseCode = con.getResponseCode();
BufferedReader in = new BufferedReader(
    new InputStreamReader(con.getInputStream()));
String inputLine;
StringBuffer response = new StringBuffer();
while ((inputLine = in.readLine()) != null) {
    response.append(inputLine);
}
in.close();
System.out.println(response.toString());

```

```go
package main

import (
       "bytes"
       "net/http"
)

func main() {

    headers := map[string][]string{
        "Accept": []string{"application/json"},
        "Authorization": []string{"API_KEY"},
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/v2/subscription/results?event_id={EVENT_ID}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /v2/subscription/results?event_id={EVENT_ID}`

Retrieves a subscription update. Included with the results is the statistical breakdown of each update and/or response that was received. Results will include status updates as well as updated card information. The total number of results will vary based on the subscription results available at a particular time. Results will remain available for 10 calendar days after the webhook is called, after which they are purged from the platform.

<h3 id="retrieve-subscription-results-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|EVENT_ID|path|string|false|none|

> Example responses
> 200 Response

```json
{
  "status": "success",
  "msg": "success",
  "data": {
    "status": "completed",
    "cards": [
      {
        "id": "aaaaaaaaaa",
        "card": "4111111111111111",
        "exp": "12/24",
        "status": "updated_card"
      }
    ],
    "stats": {
      "number_submitted": 1,
      "no_change": 0,
      "updated_card": 1,
      "updated_expiry": 0,
      "no_match": 0,
      "valid": 0,
      "contact": 0,
      "contact_closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

<h3 id="retrieve-subscription-results-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[subscription Results](#schemaretrievesubscriptionresults-200ok)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

## Delete American Express Card Subscription

<a id="opIdDeletesbatchofcardsforsubscriptions"></a>

> Code samples

```shell
# You can also use wget
curl -X DELETE https://sandbox.cardsync.io/v2/subscribe \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
DELETE https://sandbox.cardsync.io/v2/subscribe HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "cards": [
    {
      "se_number": "amex se number",
      "id": "customer identifier",
      "card": "342132335566772",
      "exp": "12/24"
    },
    {
      "se_number": "amex se number",
      "id": "customer identifier",
      "card": "376655111122997",
      "exp": "12/24"
    },
    {
      "se_number": "amex se number",
      "id": "customer identifier",
      "card": "349900006577234",
      "exp": "12/24"
    }
  ]
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/subscribe',
{
  method: 'DELETE',
  body: inputBody,
  headers: headers
})
.then(function(res) {
    return res.json();
}).then(function(body) {
    console.log(body);
});

```

```ruby
require 'rest-client'
require 'json'

headers = {
  'Content-Type' => 'application/json',
  'Accept' => 'application/json',
  'Authorization' => 'API_KEY'
}

result = RestClient.delete 'https://sandbox.cardsync.io/v2/subscribe',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'API_KEY'
}

r = requests.delete('https://sandbox.cardsync.io/v2/subscribe', headers = headers)

print(r.json())

```

```php
<?php

require 'vendor/autoload.php';

$headers = array(
    'Content-Type' => 'application/json',
    'Accept' => 'application/json',
    'Authorization' => 'API_KEY',
);

$client = new \GuzzleHttp\Client();

// Define array of request body.
$request_body = array();

try {
    $response = $client->request('DELETE','https://sandbox.cardsync.io/v2/subscribe', array(
        'headers' => $headers,
        'json' => $request_body,
       )
    );
    print_r($response->getBody()->getContents());
 }
 catch (\GuzzleHttp\Exception\BadResponseException $e) {
    // handle exception or api errors.
    print_r($e->getMessage());
 }

 // ...

```

```java
URL obj = new URL("https://sandbox.cardsync.io/v2/subscribe");
HttpURLConnection con = (HttpURLConnection) obj.openConnection();
con.setRequestMethod("DELETE");
int responseCode = con.getResponseCode();
BufferedReader in = new BufferedReader(
    new InputStreamReader(con.getInputStream()));
String inputLine;
StringBuffer response = new StringBuffer();
while ((inputLine = in.readLine()) != null) {
    response.append(inputLine);
}
in.close();
System.out.println(response.toString());

```

```go
package main

import (
       "bytes"
       "net/http"
)

func main() {

    headers := map[string][]string{
        "Content-Type": []string{"application/json"},
        "Accept": []string{"application/json"},
        "Authorization": []string{"API_KEY"},
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("DELETE", "https://sandbox.cardsync.io/v2/subscribe", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`DELETE /v2/subscribe`

This endpoint deletes previously created subscriptions for batches of American Express cards. If you no longer wish to receive updates for a particular card / SE pair, you must send a delete. Otherwise, you will continue to be charged for updates. If you submitted more than one SE number for a card, you must delete each card / SE pair submitted.

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

# Schemas

<h2 id="tocS_Card">Card</h2>
<!-- backwards compatibility -->
<a id="schemacard"></a>
<a id="schema_Card"></a>
<a id="tocScard"></a>
<a id="tocscard"></a>

```json
{
  "se_number": "1234567890",
  "id": "customer identifier",
  "card": "4012000000000016",
  "exp": "12/24"
}
```

Card

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|se_number|string|true|none|none|
|id|string|true|none|none|
|card|string|true|none|none|
|exp|string|true|none|none|

<h2 id="tocS_Stats">Stats</h2>
<!-- backwards compatibility -->
<a id="schemastats"></a>
<a id="schema_Stats"></a>
<a id="tocSstats"></a>
<a id="tocsstats"></a>

```json
{
  "number_submitted": 0,
  "no_change": 0,
  "updated_card": 0,
  "updated_expiry": 0,
  "no_match": 0,
  "valid": 0,
  "contact": 0,
  "contact_closed": 0
}
```

Stats

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|number_submitted|integer(int32)|true|none|none|
|no_change|integer(int32)|true|none|none|
|updated_card|integer(int32)|true|none|none|
|updated_expiry|integer(int32)|true|none|none|
|no_match|integer(int32)|true|none|none|
|valid|integer(int32)|true|none|none|
|contact|integer(int32)|true|none|none|
|contact_closed|integer(int32)|true|none|none|

<h2 id="tocS_Retrievesthestatusofabatchdata-200OK">Data</h2>
<!-- backwards compatibility -->
<a id="schemaretrievesthestatusofabatchdata-200ok"></a>
<a id="schema_Retrievesthestatusofabatchdata-200OK"></a>
<a id="tocSretrievesthestatusofabatchdata-200ok"></a>
<a id="tocsretrievesthestatusofabatchdata-200ok"></a>

```json
{
  "status": "success",
  "msg": "success",
  "data": {
    "status": "completed",
    "stats": {
      "number_submitted": 1,
      "no_change": 0,
      "updated_card": 1,
      "updated_expiry": 0,
      "no_match": 0,
      "valid": 0,
      "contact": 0,
      "contact_closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

Data

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|cards|[Card](#tocS_Card)|true|none|none|
|stats|[Stats](#tocS_Stats)|true|none|none|
|created_at|string|true|none|none|
|updated_at|string|true|none|none|

<h2 id="tocS_Retrievesubscriptionresults-200OK">Subscription Results</h2>
<!-- backwards compatibility -->
<a id="schemaretrievesubscriptionresults-200ok"></a>
<a id="schema_Retrievesubscriptionresults-200OK"></a>
<a id="tocSretrievesubscriptionresults-200ok"></a>
<a id="tocsretrievesubscriptionresults-200ok"></a>

The data structure returned for a card batch and a subscription result is identical except that American Express updates also contain the SE number.

```json
{
  "status": "success",
  "msg": "success",
  "data": {
    "status": "completed",
    "cards": [
      {
        "id": "aaaaaaaaaa",
        "se_number": "12334567890",
        "card": "311111111111111",
        "exp": "12/24",
        "status": "updated_card"
      }
    ],
    "stats": {
      "number_submitted": 1,
      "no_change": 0,
      "updated_card": 1,
      "updated_expiry": 0,
      "no_match": 0,
      "valid": 0,
      "contact": 0,
      "contact_closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

Subscription Results

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|msg|string|true|none|none|
|data|[Data](#tocS_Data)|true|none|none|
|stats|[Stats](#tocS_Stats)|true|none|none|

<h2 id="tocS_AmexUpdateWebhook">American Express Update Webhook</h2>
<!-- backwards compatibility -->
<a id="schemaamexupdatewebhook"></a>
<a id="schema_Amexupdatewebhook"></a>
<a id="tocSamexupdatewebhook"></a>
<a id="tocsamexupdatewebhook"></a>

```json
{
  "stats": {
    "updated_expiry": 1,
    "updated_card": 1,
    "no_change": 2,
    "no_match": 3,
    "valid": 0,
    "contact": 0,
    "closed": 0,
    "number_submitted": 8,
    "contact_closed": 1
  },
  "id": "045b35f5-aed8-4c75-97f9-942de0fc0c32",
  "trigger_id": 23,
  "trigger_date": "2021-12-08T21:39:00.349754Z",
  "event_id": "46d91344-cc41-4922-b00f-c40226b548a4",
  "message": "",
  "expires": "2021-12-09T21:39:00.349475Z"
}
```

American Express Update Webhook

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|stats|[Stats](#tocS_Stats)|true|none|none|
|id|string|true|none|none|
|trigger_id|string|true|none|none|
|trigger_date|string|true|none|none|
|event_id|string|true|none|none|
|message|string|true|none|none|
|expires|string|true|none|none|
