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

<h1 id="cardsync-universal-account-updater">CardSync Universal Account Updater</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

# Introduction

This is the API for the CardSync Universal Account service.

After signing up as a CardSync Partner, you will be able to use this API in sandbox and production. You will be provided with an API key and a Partner Billing Identifier.

This API allows Partners to enroll Merchants, submit inquiry batches of credit card numbers and expiration dates to obtain card status (including updates to card numbers and/or expiration dates) updates, and to enroll American Express cards in subscriptions for future updates.

Here are the set of steps needed to enroll a merchant and obtain card number updates:

1. (Optional) Set up webhooks to be called when merchant enrollment and batches are completed.
2. Enroll merchant with /v2/merchant POST.
3. Retrieve and save provided "merchant_id" and "api_key".
4. You may check on the status of the enrollment by calling GET /v2/merchant?merchant_id={MERCHANT_ID} or wait for the webhook to be called.

Once merchant enrollment is completed, you may submit batches and/or subscriptions.

## Batches

1. Submit a batch of Visa, Mastercard, and Discover cards via the /v2/batch POST. Save the provided "batch_id".
2. Check batch status with GET /v2/batch?batch_id={BATCH_ID} or wait for the callback that the batch has been completed. The webhook call will provide an "event_id".
3. When the batch status is complete, retrieve the results with GET /v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID}. Batches take approximately 5 business days to complete. You may omit the "event_id" if you are polling for results and are calling this API after the batch status is completed.

## Subscriptions

1. Submit a subscription request of American Express cards via the /v2/subscribe POST. 
2. When an update for one or more of those cards is available, a webhook will be called with an "event_id".
3. Retrieve the results via /v2/subscription/results?event_id={EVENT_ID}.

Each batch may consist of up to 10,000 card numbers. There is no limit on the number of consecutive batch submissions. Inquiries may return one of six responses: updated_card, updated_expiry, no_match, valid, contact, or closed. If the response is updated_card or updated_expiry, the updated card information is returned. Otherwise, one of the other four status types is returned. Some card inquiries do not result in any status type. This generally means the card is valid.

Note: American Express cards must be submitted separately from all other card types. With those batches, the merchant's SE number must be provided. If a merchant has more than one SE number, please submit one batch per SE number. The reason American Express cards are submitted separately is that the American Express cards are enrolled in a subscription for future updates. Any time that an American Express card has an subscribed update under an merchant’s SE, you will be notified via webhook to retrieve the Amex update for said Merchant."

For more information, visit <a href="https://cardsync.io">https://cardsync.io</a>.

Contact Support:  
    Email: help@cardsync.io

This document describes the CardSync v2 documentation. For the previous v1 API, please visit <a href="https://api.cardsync.io/v1/index.html">https://api.cardsync.io/v1/index.html</a>.

Base URLs:

* <a href="https://sandbox.cardsync.io/">https://sandbox.cardsync.io/</a>

# Authentication

* API Key (Authorization)
  - Parameter Name: **Authorization**, in: header.

# Webhooks

Webhooks are used for four reasons:

1. Confirmation that a merchant has been enrolled.
2. Confirmation that a batch has been completed.
3. Providing information on a batch that has an error.
4. Whenever one or more American Express cards previously submitted via batch have been updated.

## Set Up Webhooks

`POST /v2/webhooks`

This endpoint is used to set up the webhooks that are called when various events occur on the platform.

> Body parameter

```json
{
  "webhooks": [
    {
      "trigger_id": 20,   /* 20=Batch Available, 21=Enrollment Complete, 22=Batch Error, 23=Amex Update */
      "url": "batch_available_url"
    },
    {
      "trigger_id": 21,   /* 20=Batch Available, 21=Enrollment Complete, 22=Batch Error, 23=Amex Update */
      "url": "enrollment_complete_url"
    },
    {
      "trigger_id": 22,   /* 20=Batch Available, 21=Enrollment Complete, 22=Batch Error, 23=Amex Update */
      "url": "batch_error_url"
    },
    {
      "trigger_id": 23,   /* 20=Batch Available, 21=Enrollment Complete, 22=Batch Error, 23=Amex Update */
      "url": "amex_update_url"
    }
  ]
}
```

<h3 id="add-webhooks-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[Webhooks](#schemawebhooks)|true|none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

<a id="opIdSetupwebhooks"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/v2/webhooks \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/v2/webhooks HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "merchant_enrollment_webhook": "URL to be invoked when a merchant enrollment has been completed",
  "batch_completion_webhook": "URL to be invoked when a batch has been completed",
  "batch_error_webhook": "URL to be invoked when a batch has an error",
  "amex_update_webhook": "URL to be invoked when previously enrolled card(s) has/have an update"
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/webhooks',
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

result = RestClient.post 'https://sandbox.cardsync.io/v2/webhooks',
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

r = requests.post('https://sandbox.cardsync.io/v2/webhooks', headers = headers)

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
    $response = $client->request('POST','https://sandbox.cardsync.io/v2/webhooks', array(
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
URL obj = new URL("https://sandbox.cardsync.io/v2/webhooks");
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
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/v2/webhooks", data)
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
  "message": "success"
}
```

<h3 id="webhook-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Generic Response](#schemagenericresponse)|

# Merchants

Merchants are top level entities that must be enrolled for Universal Account Updater by the respective Card Brands. Use the master api_key provided to you during your account creation for this call.

This call will return a new, merchant-level api_key. This new api_key should be used for all future requests associated with the newly enrolled merchant.

## Enroll Merchant

<a id="opIdAddanewmerchant"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/v2/merchant \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/v2/merchant HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "legal_business_name": "Offical Corporate Legal Name",
  "name": "New Merchant Name",
  "description": "this is a new merchant that is getting set up",
  "website": "example.com",
  "phone": "5555555555",
  "phone_ext": "1234",
  "receipt_email": "test@example.com",
  "timezone": "UTC",
  "fee_schedule_id": "bqoa026g10l0v8o62315",
  "primary_contact": {
    "first_name": "Camille",
    "last_name": "Bauch",
    "company": "Schaefer, Lakin and Heathcote",
    "address_line_1": "188 Turnpikefort",
    "address_line_2": "",
    "city": "Langoshfort",
    "state": "VI",
    "postal_code": "31018",
    "country": "US",
    "phone": "5555555555",
    "email": "test@example.com"
  },
  "user": {
    "username": "somerandomuser20210219c",
    "email": "test@example.com",
    "status": "active",
    "role": "admin",
    "create_api_key": true
  },
  "card_info": {
    "type_of_biller": "both",
    "total_number_of_records": 400,
    "number_of_visa": 0,
    "number_of_mastercard": 0,
    "number_of_discover": 0,
    "number_of_amex": 400,
    "amex_se_number": "1234567890 <optional only used in Amex batch>",
    "delivery_frequency": "monthly",
    "mcc": "5968"
  } 
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/merchant',
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

result = RestClient.post 'https://sandbox.cardsync.io/v2/merchant',
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

r = requests.post('https://sandbox.cardsync.io/v2/merchant', headers = headers)

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
    $response = $client->request('POST','https://sandbox.cardsync.io/v2/merchant', array(
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
URL obj = new URL("https://sandbox.cardsync.io/v2/merchant");
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
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/v2/merchant", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`POST /v2/merchant`

This endpoint is used to enroll a Merchant on the platform. The fee_schedule_id will be provided to you during your Partner creation and will be the same for all Merchants you create.

> Body parameter

```json
{
  "legal_business_name": "Offical Corporate Legal Name",
  "name": "New Merchant Name",
  "description": "this is a new merchant that is getting set up",
  "website": "example.com",
  "phone": "5555555555",
  "phone_ext": "1234",
  "receipt_email": "test@example.com",
  "timezone": "UTC",
  "fee_schedule_id": "bqoa026g10l0v8o62315",
  "primary_contact": {
    "first_name": "Camille",
    "last_name": "Bauch",
    "company": "Schaefer, Lakin and Heathcote",
    "address_line_1": "188 Turnpikefort",
    "address_line_2": "",
    "city": "Langoshfort",
    "state": "VI",
    "postal_code": "31018",
    "country": "US",
    "phone": "5555555555",
    "email": "test@example.com"
  },
  "user": {
    "username": "somerandomuser20210219c",
    "email": "test@example.com",
    "status": "active",
    "role": "admin",
    "create_api_key": true
  },
  "card_info": {
    "type_of_biller": "both",
    "total_number_of_records": 300,
    "number_of_visa": 100,
    "number_of_mastercard": 100,
    "number_of_discover": 100,
    "number_of_amex": 0,
    "amex_se_number": "1234567890 <optional only used in Amex batch>",
    "delivery_frequency": "monthly",
    "mcc": "5968"
  } 
}
```

<h3 id="add-a-new-merchant-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[Merchant](#schemaaddanewmerchantrequest)|true|none|

> Example responses
> 200 Response

```json
{
  "status": "success",
  "message": "success",
  "data": {
    "merchant_id": "bqgbm86g10l2fm2bv7n0",
    "api_key": "api_1auidmDFdMslUz2R5PSwVFSEfmP",
    "created_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

<h3 id="add-a-new-merchant-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Merchant Response](#schemaenrollmerchantresponse)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

## Retrieve Enrollment Status

<a id="opIdRetrieveEnrollmentstatus"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://sandbox.cardsync.io/v2/merchant?merchant_id={MERCHANT_ID} \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/v2/merchant?merchant_id={MERCHANT_ID} HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/merchant?merchant_id={MERCHANT_ID}',
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

result = RestClient.get 'https://sandbox.cardsync.io/v2/merchant?merchant_id={MERCHANT_ID}',
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

r = requests.get('https://sandbox.cardsync.io/v2/merchant?merchant_id={MERCHANT_ID}', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/v2/merchant?merchant_id={MERCHANT_ID}', array(
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
URL obj = new URL("https://sandbox.cardsync.io/v2/merchant?merchant_id={MERCHANT_ID}");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/v2/merchant?merchant_id={MERCHANT_ID}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /v2/merchant?merchant_id={MERCHANT_ID}`

Returns the current status of the Merchant's requested enrollment. This will let you know when you may start submitting card inquiries on their behalf.

> Example responses
> 200 Response

```json
{
  "status": "success",
  "message": "success"
}
```

<h3 id="retrieve-enrollment-status-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Generic Response](#schemagenericresponse)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

# Card Updates

Card updates can be requested via two mechanisms:

1. batches
2. subscriptions

## Batches

Batches apply to Visa, Mastercard, and Discover.

A batch is a set of up to 10,000 credit card numbers and expiration dates being submitted for updates by the respective Card Issuers. If you need to send inquiries on more than 10,000 cards at once, you may submit multiple batches simultaneously.

Best practice for recurring billing (e.g. subscriptions) is to submit on a daily or weekly basis any cards being billed in the next one to two weeks. For Merchants with payment data on file, we recommend submitting those based on your average time between transactions.

Once submitted, the Card Issuers will start to return updates. In sandbox, all results (updates and/or status responses) are completed within one hour. In production, it will take 3-5 calendar days for a batch to complete.

## Subscriptions

Subscriptions apply to American Express.

A subscription is a request for ongoing updates for an enrolled card. Once a card is enrolled for updates by submitting a card number, expiration date, and SE number, any future updates to that card will result in the American Express webhook being called.

## Create Card Batch

<a id="opIdCreatesbatchofcardsforupdates"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/v2/batch \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/v2/batch HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "cards": [
    {
      "id": "<unique identifier>",
      "card": "4457010000000009",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457000300000007",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457010200000247",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4100200300011001",
      "exp": "05/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457010140000141",
      "exp": "09/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457000900000001",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5194560012341234",
      "exp": "12/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112010000000003",
      "exp": "02/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112000200000002",
      "exp": "11/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112002200000008",
      "exp": "11/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5435101234510196",
      "exp": "07/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010000000003",
      "exp": "03/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010140000004",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6500102012345662",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011102087026223",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010100000002",
      "exp": "08/50"
    }
  ]
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/batch',
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

result = RestClient.post 'https://sandbox.cardsync.io/v2/batch',
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

r = requests.post('https://sandbox.cardsync.io/v2/batch', headers = headers)

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
    $response = $client->request('POST','https://sandbox.cardsync.io/v2/batch', array(
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
URL obj = new URL("https://sandbox.cardsync.io/v2/batch");
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
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/v2/batch", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`POST /v2/batch`

This endpoint requests updates for card batches.

## Mastercard / Visa / Discover Test Data (Sandbox only)

You can supply any Luhn10 valid card number, but to trigger specific responses, please use the following test card numbers in the sandbox environment.

### Visa Test Cards

- 4457010000000009 / 01/50 - updated_card  
- 4457000300000007 / 01/50 - updated_expiry  
- 4457010200000247 / 08/50 - no_match  
- 4100200300011001 / 05/50 - valid  
- 4457010140000141 / 09/50 - contact  
- 4457000900000001 / 08/50 - closed  

### Mastercard Test Cards

- 5194560012341234 / 12/50 - updated_card  
- 5112010000000003 / 02/50 - updated_expiry  
- 5112000200000002 / 11/50 - no_match
- 5112002200000008 / 11/50 - valid
- 5435101234510196 / 07/50 - closed

### Discover Test Cards

- 6011010000000003 / 03/50 - updated_card
- 6011010140000004 / 08/50 - updated_expiry
- 6500102012345662 / 01/50 - valid
- 6011102087026223 / 01/50 - contact
- 6011010100000002 / 08/50 - closed

> Body parameter

```json
{
  "cards": [
    {
      "id": "<unique identifier>",
      "card": "4457010000000009",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457000300000007",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457010200000247",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4100200300011001",
      "exp": "05/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457010140000141",
      "exp": "09/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457000900000001",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5194560012341234",
      "exp": "12/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112010000000003",
      "exp": "02/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112000200000002",
      "exp": "11/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112002200000008",
      "exp": "11/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5435101234510196",
      "exp": "07/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010000000003",
      "exp": "03/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010140000004",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6500102012345662",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011102087026223",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010100000002",
      "exp": "08/50"
    }
  ]
}
```

<h3 id="creates-batch-of-cards-for-updates-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[Card Batch](#schemacreatesbatchofcardsforupdatesrequest)|true|none|

> Example responses
> 200 Response

```json
{
  "status": "success",
  "message": "success",
  "data": {
    "status": "pending",
    "stats": {
      "number_submitted": 0,
      "no_change": 0,
      "updated_card": 0,
      "updated_expiry": 0,
      "no_match": 0,
      "valid": 0,
      "contact": 0,
      "closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

<h3 id="creates-batch-of-cards-for-updates-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Card Batch Response](#schemacreatesabatchofcardsforupdates-200ok)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

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
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "342132335566772",
      "exp": "12/28"
    },
    {
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "376655111122997",
      "exp": "12/28"
    },
    {
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "349900006577234",
      "exp": "12/28"
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
349900006577234 - closed  

> Body parameter

```json
{
  "cards": [
    {
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "342132335566772",
      "exp": "12/28"
    },
    {
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "376655111122997",
      "exp": "12/28"
    },
    {
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "349900006577234",
      "exp": "12/28"
    }
  ]
}

## Retrieve Batch Status

<a id="opIdRetrievesthestatusofabatch"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://sandbox.cardsync.io/v2/batch?batch_id={BATCH_ID} \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/v2/batch?batch_id={BATCH_ID} HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/batch?batch_id={BATCH_ID}',
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

result = RestClient.get 'https://sandbox.cardsync.io/v2/batch?batch_id={BATCH_ID}',
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

r = requests.get('https://sandbox.cardsync.io/v2/batch?batch_id={BATCH_ID}', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/v2/batch?batch_id={BATCH_ID}', array(
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
URL obj = new URL("https://sandbox.cardsync.io/v2/batch?batch_id={BATCH_ID}");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/v2/batch?batch_id={BATCH_ID}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /v2/batch?batch_id={BATCH_ID}`

Retrieve the status of a batch. Batches in the sandbox will be completed within one hour. Batches in production will take 3-5 calendar days to complete.

<h3 id="retrieves-the-status-of-a-batch-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|BATCH_ID|path|string|true|none|

> Example responses
> 200 Response

```json
{
  "status": "success",
  "message": "success",
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
      "closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

<h3 id="retrieves-the-status-of-a-batch-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Batch Status](#schemaretrievesthestatusofabatch-200ok)|

<h3 id="retrieves-the-status-of-a-batch-responseschema">Response Schema</h3>

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

## Retrieve Batch Results

<a id="opIdRetrievebatchresults"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://sandbox.cardsync.io/v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID} \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID} HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID}',
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

result = RestClient.get 'https://sandbox.cardsync.io/v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID}',
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

r = requests.get('https://sandbox.cardsync.io/v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID}', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID}', array(
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
URL obj = new URL("https://sandbox.cardsync.io/v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID}");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /v2/batch/results?batch_id={BATCH_ID}&event_id={EVENT_ID}`

Retrieves a completed batch. Included with the batch results is the statistical breakdown of each update and/or response that was received. Results will include status updates as well as updated card information. The total number of results may be less than the number of cards submitted. Batch results will remain available for 10 calendar days after the batch completes, after which they are purged from the platform.

<h3 id="retrieve-batch-results-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|BATCH_ID|path|string|true|none|
|EVENT_ID|path|string|false|none|

> Example responses
> 200 Response

```json
{
  "status": "success",
  "message": "success",
  "data": {
    "status": "completed",
    "cards": [
      {
        "id": "aaaaaaaaaa",
        "card": "4111111111111111",
        "exp": "12/28",
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
      "closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

<h3 id="retrieve-batch-results-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Batch Results](#schemaretrievebatchresults-200ok)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

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
  "message": "success",
  "data": {
    "status": "completed",
    "cards": [
      {
        "id": "aaaaaaaaaa",
        "card": "4111111111111111",
        "exp": "12/28",
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
      "closed": 0
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
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "342132335566772",
      "exp": "12/28"
    },
    {
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "376655111122997",
      "exp": "12/28"
    },
    {
      "se_number": "1234567890",
      "id": "<unique identifier>",
      "card": "349900006577234",
      "exp": "12/28"
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

<h2 id="tocS_Addwebhooks">Webhooks</h2>
<!-- backwards compatibility -->
<a id="schemawebhooks"></a>
<a id="schema_Webhooks"></a>
<a id="tocSwebhooks"></a>
<a id="tocswebhooks"></a>

```json
{
  "webhooks": [
    {
      "trigger_id": 20,   /* 20=Batch Available, 21=Enrollment Complete, 22=Batch Error, 23=Amex Update */
      "url": "batch_available_url"
    },
    {
      "trigger_id": 21,   /* 20=Batch Available, 21=Enrollment Complete, 22=Batch Error, 23=Amex Update */
      "url": "enrollment_complete_url"
    },
    {
      "trigger_id": 22,   /* 20=Batch Available, 21=Enrollment Complete, 22=Batch Error, 23=Amex Update */
      "url": "batch_error_url"
    },
    {
      "trigger_id": 23,   /* 20=Batch Available, 21=Enrollment Complete, 22=Batch Error, 23=Amex Update */
      "url": "amex_update_url"
    }
  ]
}
```

Webhook Array

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|batch_completion_webhook|string|false|none|trigger_id = 20|
|merchant_enrollment_webhook|string|false|none|trigger_id = 21|
|batch_error_webhook|string|false|none|trigger_id = 22|
|amex_update_webhook|string|false|none|trigger_id = 23|

<h2 id="tocS_AddanewmerchantRequest">Merchant</h2>
<!-- backwards compatibility -->
<a id="schemaaddanewmerchantrequest"></a>
<a id="schema_AddanewmerchantRequest"></a>
<a id="tocSaddanewmerchantrequest"></a>
<a id="tocsaddanewmerchantrequest"></a>

```json
{
  "legal_business_name": "Offical Corporate Legal Name",
  "name": "New Merchant Name",
  "description": "this is a new merchant that is getting set up",
  "website": "example.com",
  "phone": "5555555555",
  "phone_ext": "1234",
  "receipt_email": "test@example.com",
  "timezone": "UTC",
  "fee_schedule_id": "bqoa026g10l0v8o62315",
  "primary_contact": {
    "first_name": "Camille",
    "last_name": "Bauch",
    "company": "Schaefer, Lakin and Heathcote",
    "address_line_1": "188 Turnpikefort",
    "address_line_2": "",
    "city": "Langoshfort",
    "state": "VI",
    "postal_code": "31018",
    "country": "US",
    "phone": "5555555555",
    "email": "test@example.com"
  },
  "user": {
    "username": "somerandomuser20210219c",
    "email": "test@example.com",
    "status": "active",
    "role": "admin",
    "create_api_key": true
  },
  "card_info": {
    "type_of_biller": "both",
    "total_number_of_records": 300,
    "number_of_visa": 100,
    "number_of_mastercard": 100,
    "number_of_discover": 100,
    "number_of_amex": 0,
    "amex_se_number": "1234567890 <optional needed only in Amex batch>",
    "delivery_frequency": "monthly",
    "mcc": "5968"
  }
}
```

Merchant

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|legal_business_name|string|true|none|must be unique|
|name|string|true|none|none|
|description|string|true|none|none|
|website|string|true|none|none|
|phone|string|true|none|none|
|phone_ext|string|false|none|none|
|receipt_email|string|true|none|none|
|timezone|string|true|none|none|
|fee_schedule_id|string|true|none|none|
|primary_contact|[PrimaryContact](#schemaprimarycontact)|true|none|none|
|user|[User](#schemauser)|true|none|none|
|card_info|[CardInfo](#schemacardinfo)|true|none|none|

<h2 id="tocS_PrimaryContact">Primary Contact</h2>
<!-- backwards compatibility -->
<a id="schemaprimarycontact"></a>
<a id="schema_PrimaryContact"></a>
<a id="tocSprimarycontact"></a>
<a id="tocsprimarycontact"></a>

```json
{
  "first_name": "Camille",
  "last_name": "Bauch",
  "company": "Schaefer, Lakin and Heathcote",
  "address_line_1": "188 Turnpikefort",
  "address_line_2": "",
  "city": "Langoshfort",
  "state": "VI",
  "postal_code": "31018",
  "country": "US",
  "phone": "5555555555",
  "email": "test@example.com"
}

```

Primary Contact

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|first_name|string|true|none|none|
|last_name|string|true|none|none|
|company|string|true|none|none|
|address_line_1|string|true|none|none|
|address_line_2|string|true|none|none|
|city|string|true|none|none|
|state|string|true|none|none|
|postal_code|string|true|none|none|
|country|string|true|none|none|
|phone|string|true|none|none|
|email|string|true|none|none|

<h2 id="tocS_User">User</h2>
<!-- backwards compatibility -->
<a id="schemauser"></a>
<a id="schema_User"></a>
<a id="tocSuser"></a>
<a id="tocsuser"></a>

```json
{
  "username": "somerandomuser20210219c",
  "email": "test@example.com",
  "status": "active",
  "role": "admin",
  "create_api_key": true
}

```

User

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|username|string|true|none|must be unique|
|email|string|true|none|none|
|status|string|true|none|none|
|role|string|true|none|none|
|create_api_key|boolean|true|none|none|

<h2 id="tocS_cardinfo">Card Info</h2>
<!-- backwards compatibility -->
<a id="schemacardinfo"></a>
<a id="schema_CardInfo"></a>
<a id="tocScardinfo"></a>
<a id="tocscardinfo"></a>

```json
{
  "type_of_biller": "both",
  "total_number_of_records": 400,
  "number_of_visa": 100,
  "number_of_mastercard": 100,
  "number_of_discover": 100,
  "number_of_amex": 0,
  "amex_se_number": "1234567890 <optional only used in Amex batch>",
  "delivery_frequency": "monthly",
  "mcc": "5968"
}
```

Card Info

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|type_of_biller|string|true|none|none|
|total_number_of_records|integer(int32)|true|none|none|
|number_of_visa|integer(int32)|true|none|none|
|number_of_mastercard|integer(int32)|true|none|none|
|number_of_discover|integer(int32)|true|none|none|
|number_of_amex|integer(int32)|true|none|none|
|amex_se_number|string|false|none|none|
|delivery_frequency|string|true|daily, weekly, monthly|none|
|mcc|string|true|none|none|

<h2 id="tocS_EnrollMerchantResponse">Enroll Merchant Response</h2>
<!-- backwards compatibility -->
<a id="schemaenrollmerchantresponse"></a>
<a id="schema_Enrollmerchantresponse"></a>
<a id="tocSenrollmerchantresponse"></a>
<a id="tocsenrollmerchantresponse"></a>

```json
{
  "status": "success",
  "message": "success",
  "data": {
    "merchant_id": "bqgbm86g10l2fm2bv7n0",
    "api_key": "api_1auidmDFdMslUz2R5PSwVFSEfmP",
    "created_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

Enroll Merchant Response

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|message|string|true|none|none|
|merchant_id|string|true|none|inside data object|
|api_key|string|true|none|inside data object|
|created_at|string|true|none|inside data object|

<h2 id="tocS_GenericResponse">Generic Response</h2>
<!-- backwards compatibility -->
<a id="schemagenericresponse"></a>
<a id="schema_genericresponse"></a>
<a id="tocSgenericresponse"></a>
<a id="tocsgenericresponse"></a>

```json
{
  "status": "success",
  "message": "success"
}
```

Generic Response

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|message|string|true|none|none|

<h2 id="tocS_BillingContact">Billing Contact</h2>
<!-- backwards compatibility -->
<a id="schemabillingcontact"></a>
<a id="schema_BillingContact"></a>
<a id="tocSbillingcontact"></a>
<a id="tocsbillingcontact"></a>

```json
{
  "first_name": "Camille",
  "last_name": "Bauch",
  "company": "Schaefer, Lakin and Heathcote",
  "address_line_1": "188 Turnpikefort",
  "address_line_2": "",
  "city": "Langoshfort",
  "state": "VI",
  "postal_code": "31018",
  "country": "US",
  "phone": "7177546366",
  "phone_ext": "1234",
  "fax": "",
  "email": "test@example.com"
}

```

Billing Contact

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|first_name|string|true|none|none|
|last_name|string|true|none|none|
|company|string|true|none|none|
|address_line_1|string|true|none|none|
|address_line_2|string|true|none|none|
|city|string|true|none|none|
|state|string|true|none|none|
|postal_code|string|true|none|none|
|country|string|true|none|none|
|phone|string|true|none|none|
|phone_ext|string|false|none|none|
|fax|string|true|none|none|
|email|string|true|none|none|

<h2 id="tocS_CreatesbatchofcardsforupdatesRequest">Card Batch</h2>
<!-- backwards compatibility -->
<a id="schemacreatesbatchofcardsforupdatesrequest"></a>
<a id="schema_CreatesbatchofcardsforupdatesRequest"></a>
<a id="tocScreatesbatchofcardsforupdatesrequest"></a>
<a id="tocscreatesbatchofcardsforupdatesrequest"></a>

```json
{
  "cards": [
    {
      "se": "1234567890 <American Express subscriptions only>",
      "id": "<unique identifier>",
      "card": "4457010000000009",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457000300000007",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457010200000247",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4100200300011001",
      "exp": "05/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457010140000141",
      "exp": "09/50"
    },
    {
      "id": "<unique identifier>",
      "card": "4457000900000001",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5194560012341234",
      "exp": "12/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112010000000003",
      "exp": "02/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112000200000002",
      "exp": "11/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5112002200000008",
      "exp": "11/50"
    },
    {
      "id": "<unique identifier>",
      "card": "5435101234510196",
      "exp": "07/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010000000003",
      "exp": "03/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010140000004",
      "exp": "08/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6500102012345662",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011102087026223",
      "exp": "01/50"
    },
    {
      "id": "<unique identifier>",
      "card": "6011010100000002",
      "exp": "08/50"
    }
  ]
}

```

Card Batch

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|se_number|string|false|none|American Express subscriptions only|
|cards|[[Card](#schemacard)]|true|none|none|

<h2 id="tocS_Card">Card</h2>
<!-- backwards compatibility -->
<a id="schemacard"></a>
<a id="schema_Card"></a>
<a id="tocScard"></a>
<a id="tocscard"></a>

```json
{
  "se": "1234567890 <American Express subscriptions only>",
  "id": "<unique identifier>",
  "card": "4457010000000009",
  "exp": "01/50"
}

```

Card

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|se_number|string|false|none|American Express subscriptions only|
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
  "closed": 0
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
|closed|integer(int32)|true|none|none|

<h2 id="tocS_Retrievesthestatusofabatch-200OK">Batch Results Status</h2>
<!-- backwards compatibility -->
<a id="schemaretrievesthestatusofabatch-200ok"></a>
<a id="schema_Retrievesthestatusofabatch-200OK"></a>
<a id="tocSretrievesthestatusofabatch-200ok"></a>
<a id="tocsretrievesthestatusofabatch-200ok"></a>

```json
{
  "status": "success",
  "message": "success",
  "data": {
    "batch_id": "bqgbm86g10l2fm2bv7n1",
    "status": "completed",
    "stats": {
      "number_submitted": 1,
      "no_change": 0,
      "updated_card": 1,
      "updated_expiry": 0,
      "no_match": 0,
      "valid": 0,
      "contact": 0,
      "closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}

```

Retrieve Batch Status

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|msg|string|true|none|none|
|data|[Data](#tocS_Retrievesthestatusofabatchdata-200OK)|true|none|none|

<h2 id="tocS_Retrievesthestatusofabatchdata-200OK">Batch Status Data</h2>
<!-- backwards compatibility -->
<a id="schemaretrievesthestatusofabatchdata-200ok"></a>
<a id="schema_Retrievesthestatusofabatchdata-200OK"></a>
<a id="tocSretrievesthestatusofabatchdata-200ok"></a>
<a id="tocsretrievesthestatusofabatchdata-200ok"></a>

```json
{
  "status": "success",
  "message": "success",
  "data": {
    "batch_id": "bqgbm86g10l2fm2bv7n1",
    "status": "completed",
    "stats": {
      "number_submitted": 1,
      "no_change": 0,
      "updated_card": 1,
      "updated_expiry": 0,
      "no_match": 0,
      "valid": 0,
      "contact": 0,
      "closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}

```

Batch Status Data

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|msg|string|true|none|none|
|data|[Data](#schemadata4)|true|none|none|

<h2 id="tocS_Retrievebatchresults-200OK">Batch / Subscription Results</h2>
<!-- backwards compatibility -->
<a id="schemaretrievebatchresults-200ok"></a>
<a id="schema_Retrievebatchresults-200OK"></a>
<a id="tocSretrievebatchresults-200ok"></a>
<a id="tocsretrievebatchresults-200ok"></a>

The data structure returned for a card batch and a subscription result is identical except that American Express updates also contain the SE number.

```json
{
  "status": "success",
  "message": "success",
  "data": {
    "status": "completed",
    "cards": [
      {
        "id": "aaaaaaaaaa",
        "se_number": "12334567890 <present only for American Express>",
        "card": "378282246310005",
        "exp": "12/28",
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
      "closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}

```

Batch Results

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|msg|string|true|none|none|
|data|[Data](#tocS_Retrievebatchresultsdata-200OK)|true|none|none|
|stats|[Stats](#tocS_Stats)|true|none|none|

<h2 id="tocS_Retrievebatchresultsdata-200OK">Batch Results Data</h2>
<!-- backwards compatibility -->
<a id="schemaretrievebatchresultsdata-200ok"></a>
<a id="schema_Retrievebatchresultsdata-200OK"></a>
<a id="tocSretrievebatchresultsdata-200ok"></a>
<a id="tocsretrievebatchresultsdata-200ok"></a>

```json
{
  "status": "success",
  "message": "success",
  "data": {
    "status": "completed",
    "cards": [
      {
        "id": "<unique identifier>",
        "card": "4111111111111111",
        "exp": "12/28",
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
      "closed": 0
    },
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z"
  }
}
```

Batch Results Data

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|batch_id|string|true|none|Visa/MasterCard/Discover only|
|status|string|true|none|none|
|cards|[Card]|true|none|none|
|stats|[Stats]|true|none|none|
|created_at|string|true|none|none|
|updated_at|string|true|none|none|

<h2 id="tocS_EnrollMerchantWebhook">Enroll Merchant Webhook</h2>
<!-- backwards compatibility -->
<a id="schemaenrollmerchantwebhook"></a>
<a id="schema_Enrollmerchantwebhook"></a>
<a id="tocSenrollmerchantwebhook"></a>
<a id="tocsenrollmerchantwebhook"></a>

```json
{
  "status": "success",
  "message": "success",
  "merchant_id": "bqgbm86g10l2fm2bv7n0"
}
```

Enroll Merchant Webhook

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|message|string|true|none|none|
|merchant_id|string|true|none|merchant id from the POST /v2/merchant call|

<h2 id="tocS_BatchCompletionWebhook">Batch Completion Webhook</h2>
<!-- backwards compatibility -->
<a id="schemabatchcompletionwebhook"></a>
<a id="schema_Batchcompletionwebhook"></a>
<a id="tocSbatchcompletionwebhook"></a>
<a id="tocsbatchcompletionwebhook"></a>

```json
{
  "batch_id": "b9ec0c1776655524350",  
  "card_stats": {
    "visa": 0,
    "mastercard": 8,
    "discover": 0,
    "american_express": 0
  },
  "stats": {
    "updated_expiry": 1,
    "updated_card": 1,
    "no_change": 2,
    "no_match": 3,
    "valid": 0,
    "contact": 0,
    "closed": 0,
    "number_submitted": 8,
    "closed": 1
  },
  "id": "60d7a065-1795-4e98-88af-a8b98db9ec0c",
  "trigger_id": 20,
  "trigger_date": "2021-12-08T21:39:00.349754Z",
  "event_id": "c7a8da62-473d-4153-91d6-d6fddd3d7252",
  "message": "",
  "expires": "2021-12-09T21:39:00.349475Z"
}
```

Batch Completion Webhook

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|batch_id|string|true|none|none|
|card_stats|string|true|none|none|
|stats|[Stats](#tocS_Stats)|true|none|none|
|id|string|true|none|none|
|trigger_id|string|true|none|none|
|trigger_date|string|true|none|none|
|event_id|string|true|none|none|
|message|string|true|none|none|
|expires|string|true|none|none|

<h2 id="tocS_AmexUpdateWebhook">Amex Update Webhook</h2>
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
    "closed": 1
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

<h2 id="tocS_BatchErrorWebhook">Batch Error Webhook</h2>
<!-- backwards compatibility -->
<a id="schemabatcherrorwebhook"></a>
<a id="schema_Batcherrorwebhook"></a>
<a id="tocSbatcherrorwebhook"></a>
<a id="tocsbatcherrorwebhook"></a>

```json
{
  "batch_id": "b9ec0c1776655524350",  
  "id": "60d7a065-1795-4e98-88af-a8b98db9ec0c",
  "trigger_id": 22,
  "trigger_date": "2021-12-08T21:39:00.349754Z",
  "event_id": "c7a8da62-473d-4153-91d6-d6fddd3d7252",
  "source": "Validation",
  "message": "3 errors occurred in during the batch validation process",
  "error_count": 3
}
```

Batch Error Webhook

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|batch_id|string|true|none|none|
|id|string|true|none|none|
|trigger_id|string|true|none|none|
|trigger_date|string|true|none|none|
|event_id|string|true|none|none|
|source|string|true|none|none|
|message|string|true|none|none|
|error_count|integer(int32)|true|none|none|
