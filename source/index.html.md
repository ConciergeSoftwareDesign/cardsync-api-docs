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

This is the API for the CardSync Universal Account service.

After signing up as a CardSync Partner, you will be able to use this API in sandbox and production. You will be provided with an API key and a Partner Billing Identifier.

This API allows Partners to enroll Merchants and submit inquiry batches of credit card numbers and expiration dates to obtain card status (including updates to card numbers and/or expiration dates) or status updates.

Here are the set of steps needed to enroll a merchant and obtain card number updates:

1. (Optional) Set up webhooks to be called when merchant enrollment and batches are completed.
2. Enroll merchant with /merchant POST.
3. Retrieve and save provided "id" and "api_key".
4. After merchant enrollment is completed (up to five business days), batches can be submitted via the /batch POST. Save the provided "batch_id".
5. Check batch status with GET /batch/{batch_id} or wait for the callback that the batch has been completed.
6. When the batch status is complete, retrieve the results with GET /batch/{batch_id}/results. Batches take approximately 5 business days to complete.

Each batch may consist of up to 10,000 card numbers. There is no limit on the number of consecutive batch submissions. Inquiries may return one of six responses: updated_card, updated_expiry, no_match, valid, contact, or contact_closed. If the response is updated_card or updated_expiry, the updated card information is returned. Otherwise, one of the other four status types is returned. Some card inquiries do not result in any status type. This generally means the card is valid.

For more information, visit https://cardsync.io.

Contact Support:  
    Email: help@cardsync.io

Base URLs:

* <a href="https://sandbox.cardsync.io/api">https://sandbox.cardsync.io/api</a>

# Authentication

* API Key (Authorization)
  - Parameter Name: **Authorization**, in: header.

# Webhooks

Webhooks are used for three reasons:

1. Confirmation that a merchant has been enrolled.
2. Confirmation that a batch has been completed.
3. Whenever one or more American Express cards previously submitted via batch have been updated.

## Set Up Webhooks

`POST /webhooks`

This endpoint is used to set up the webhooks that are called when various events occur on the platform.

> Body parameter

```json
{
  "merchant_enrollment_webhook": "URL to be invoked when a merchant enrollment has been completed",
  "batch_completion_webhook": "URL to be invoked when a batch has been completed",
  "amex_update_webhook": "URL to be invoked when previously enrolled card(s) has/have an update"
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
curl -X POST https://sandbox.cardsync.io/api/webhooks \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/api/webhooks HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "merchant_enrollment_webhook": "URL to be invoked when a merchant enrollment has been completed",
  "batch_completion_webhook": "URL to be invoked when a batch has been completed",
  "amex_update_webhook": "URL to be invoked when previously enrolled card(s) has/have an update"
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/api/webhooks',
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

result = RestClient.post 'https://sandbox.cardsync.io/api/webhooks',
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

r = requests.post('https://sandbox.cardsync.io/api/webhooks', headers = headers)

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
    $response = $client->request('POST','https://sandbox.cardsync.io/api/webhooks', array(
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
URL obj = new URL("https://sandbox.cardsync.io/api/webhooks");
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
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/api/webhooks", data)
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

# Merchants

Merchants are top level entities that must be enrolled for Universal Account Updater by the respective Card Brands. Use the master api_key provided to you during your account creation for this call.

This call will return a new, merchant-level api_key. This new api_key should be used for all future requests associated with the newly enrolled merchant.

## Enroll Merchant

<a id="opIdAddanewmerchant"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/api/merchant \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/api/merchant HTTP/1.1
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
    "amex_se_number": "1234567890 <optional only used in Amem batch>",
    "delivery_frequency": "monthly",
    "mcc": "5968"
  } 
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/api/merchant',
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

result = RestClient.post 'https://sandbox.cardsync.io/api/merchant',
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

r = requests.post('https://sandbox.cardsync.io/api/merchant', headers = headers)

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
    $response = $client->request('POST','https://sandbox.cardsync.io/api/merchant', array(
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
URL obj = new URL("https://sandbox.cardsync.io/api/merchant");
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
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/api/merchant", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`POST /merchant`

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
    "amex_se_number": "1234567890 <optional only used in Amem batch>",
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
  "msg": "success",
  "data": {
    "id": "bqgbm86g10l2fm2bv7n0",
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
curl -X GET https://sandbox.cardsync.io/merchant/{MERCHANT_ID} \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/merchant/{MERCHANT_ID} HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/merchant/{MERCHANT_ID}',
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

result = RestClient.get 'https://sandbox.cardsync.io/merchant/{MERCHANT_ID}',
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

r = requests.get('https://sandbox.cardsync.io/merchant/{MERCHANT_ID}', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/merchant/{MERCHANT_ID}', array(
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
URL obj = new URL("https://sandbox.cardsync.io/merchant/{MERCHANT_ID}");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/merchant/{MERCHANT_ID}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /merchant/{MERCHANT_ID}`

Returns the current status of the Merchant's requested enrollment. This will let you know when you may start submitting card inquiries on their behalf.

> Example responses
> 200 Response

```json
{
  "status": "success",
  "msg": "success"
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

<h1 id="cardsync-universal-account-updater-batch">Batch</h1>

A batch is a set of up to 10,000 credit card numbers and expiration dates being submitted for updates by the respective Card Issuers. If you need to send inquiries on more than 10,000 cards at once, you may submit multiple batches simultaneously.

Best practice for recurring billing (e.g. subscriptions) is to submit on a daily or weekly basis any cards being billed in the next one to two weeks. For Merchants with payment data on file, we recommend submitting those based on your average time between transactions.

Once submitted, the Card Issuers will start to return updates. In sandbox, all results (updates and/or status responses) are completed within one hour. In production, it will take 3-5 calendar days for a batch to complete.

## Create Card Batch

<a id="opIdCreatesbatchofcardsforupdates"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/batch \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/batch HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "cards": [
    {
      "id": "customer identifier",
      "card": "4012000000000016",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000024",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000032",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000040",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000057",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000065",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000016",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000024",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000032",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000040",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000057",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000065",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000012",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000020",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000038",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000046",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000053",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000061",
      "exp": "12/24"
    }
  ]
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/batch',
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

result = RestClient.post 'https://sandbox.cardsync.io/batch',
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

r = requests.post('https://sandbox.cardsync.io/batch', headers = headers)

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
    $response = $client->request('POST','https://sandbox.cardsync.io/batch', array(
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
URL obj = new URL("https://sandbox.cardsync.io/batch");
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
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/batch", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`POST /cardsync/batch`

This endpoint requests updates for card batches.

## Test Data (Sandbox only)

You can supply any Luhn10 valid card number, but to trigger specific responses, please use the following test card numbers in the sandbox environment.

### Visa Test Cards

4012000000000016 - updated_card  
4012000000000024 - updated_expiry  
4012000000000032 - no_match  
4012000000000040 - valid  
4012000000000057 - contact  
4012000000000065 - contact_closed  

### MC Test Cards

5442980000000016 - updated_card  
5442980000000024 - updated_expiry  
5442980000000032 - no_match
5442980000000040 - valid  
5442980000000057 - contact  
5442980000000065 - contact_closed  

### Discover Test Cards

6011000000000012 - updated_card  
6011000000000020 - updated_expiry
6011000000000038 - no_match  
6011000000000046 - valid  
6011000000000053 - contact  
6011000000000061 - contact_closed

> Body parameter

```json
{
  "cards": [
    {
      "id": "customer identifier",
      "card": "4012000000000016",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000024",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000032",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000040",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000057",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000065",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000016",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000024",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000032",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000040",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000057",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000065",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000012",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000020",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000038",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000046",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000053",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000061",
      "exp": "12/24"
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
  "msg": "success",
  "data": {
    "batch_id": "bqgbm86g10l2fm2bv7n0",
    "status": "pending",
    "stats": {
      "number_submitted": 0,
      "no_change": 0,
      "updated_card": 0,
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

<h3 id="creates-batch-of-cards-for-updates-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Card Batch Response](#schemacreatesabatchofcardsforupdates-200ok)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

## Retrieve Batch Status

<a id="opIdRetrievesthestatusofabatch"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://sandbox.cardsync.io/batch/{BATCH_ID} \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/batch/{BATCH_ID} HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/batch/{BATCH_ID}',
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

result = RestClient.get 'https://sandbox.cardsync.io/batch/{BATCH_ID}',
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

r = requests.get('https://sandbox.cardsync.io/batch/{BATCH_ID}', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/batch/{BATCH_ID}', array(
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
URL obj = new URL("https://sandbox.cardsync.io/batch/{BATCH_ID}");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/batch/{BATCH_ID}", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /cardsync/batch/{BATCH_ID}`

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
  "msg": "success",
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
      "contact_closed": 0
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
curl -X GET https://sandbox.cardsync.io/batch/{BATCH_ID}/results \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/batch/{BATCH_ID}/results HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/batch/{BATCH_ID}/results',
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

result = RestClient.get 'https://sandbox.cardsync.io/batch/{BATCH_ID}/results',
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

r = requests.get('https://sandbox.cardsync.io/batch/{BATCH_ID}/results', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/batch/{BATCH_ID}/results', array(
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
URL obj = new URL("https://sandbox.cardsync.io/batch/{BATCH_ID}/results");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/batch/{BATCH_ID}/results", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /cardsync/batch/{BATCH_ID}/results`

Retrieves a completed batch. Included with the batch results is the statistical breakdown of each update and/or response that was received. Results will include status updates as well as updated card information. The total number of results may be less than the number of cards submitted. Batch results will remain available for 10 calendar days after the batch completes, after which they are purged from the platform.

<h3 id="retrieve-batch-results-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|BATCH_ID|path|string|true|none|

> Example responses
> 200 Response

```json
{
  "status": "success",
  "msg": "success",
  "data": {
    "batch_id": "bqgbm86g10l2fm2bv7n1",
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

<h3 id="retrieve-batch-results-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Batch Results](#schemaretrievebatchresults-200ok)|

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
  "merchant_enrollment_webhook": "URL to be invoked when a merchant enrollment has been completed",
  "batch_completion_webhook": "URL to be invoked when a batch has been completed",
  "amex_update_webhook": "URL to be invoked when previously enrolled card(s) has/have an update"
}
```

Webhooks

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|merchant_enrollment_webhook|string|true|none|none|
|batch_completion_webhook|string|true|none|none|
|amex_update_webhook|string|true|empty string if no amex|none|

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
    "amex_se_number": "1234567890 <optional only used in Amem batch>",
    "delivery_frequency": "monthly",
    "mcc": "5968"
  }
}
```

Merchant

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|legal_business_name|string|true|none|none|
|name|string|true|none|none|
|description|string|true|none|none|
|website|string|true|none|none|
|phone|string|true|none|none|
|phone_ext|string|true|none|none|
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
|username|string|true|none|none|
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
  "amex_se_number": "1234567890 <optional only used in Amem batch>",
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
|delivery_frequency|string|true|none|none|
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
  "id": "bqgbm86g10l2fm2bv7n0",
  "api_key": "api_1auidmDFdMslUz2R5PSwVFSEfmP"
}
```

Enroll Merchant Response

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|message|string|true|none|none|
|id|string|true|none|none|
|api_key|string|true|none|none|

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
  "phone_ext": "",
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
|phone_ext|string|true|none|none|
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
  "amex_se_number": "1234567890 <optional only used in Amem batch>",
  "cards": [
    {
      "id": "customer identifier",
      "card": "4012000000000016",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000024",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000032",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000040",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000057",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "4012000000000065",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000016",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000024",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000032",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000040",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000057",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "5442980000000065",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000012",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000020",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000038",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000046",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000053",
      "exp": "12/24"
    },
    {
      "id": "customer identifier",
      "card": "6011000000000061",
      "exp": "12/24"
    }
  ]
}

```

Card Batch

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|amex_se_number|string|false|none|none|
|cards|[[Card](#schemacard)]|true|none|none|

<h2 id="tocS_Card">Card</h2>
<!-- backwards compatibility -->
<a id="schemacard"></a>
<a id="schema_Card"></a>
<a id="tocScard"></a>
<a id="tocscard"></a>

```json
{
  "id": "customer identifier",
  "card": "4012000000000016",
  "exp": "12/24"
}

```

Card

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
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

<h2 id="tocS_Retrievesthestatusofabatch-200OK">Batch Status</h2>
<!-- backwards compatibility -->
<a id="schemaretrievesthestatusofabatch-200ok"></a>
<a id="schema_Retrievesthestatusofabatch-200OK"></a>
<a id="tocSretrievesthestatusofabatch-200ok"></a>
<a id="tocsretrievesthestatusofabatch-200ok"></a>

```json
{
  "status": "success",
  "msg": "success",
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
      "contact_closed": 0
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
  "msg": "success",
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
      "contact_closed": 0
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

<h2 id="tocS_Retrievebatchresults-200OK">Batch Results</h2>
<!-- backwards compatibility -->
<a id="schemaretrievebatchresults-200ok"></a>
<a id="schema_Retrievebatchresults-200OK"></a>
<a id="tocSretrievebatchresults-200ok"></a>
<a id="tocsretrievebatchresults-200ok"></a>

```json
{
  "status": "success",
  "msg": "success",
  "data": {
    "batch_id": "bqgbm86g10l2fm2bv7n1",
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
  "msg": "success",
  "data": {
    "batch_id": "bqgbm86g10l2fm2bv7n1",
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

Batch Results Data

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|batch_id|string|true|none|none|
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
  "msg": "success",
  "id": "bqgbm86g10l2fm2bv7n0"
}
```

Enrollment Merchant Webhook

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|message|string|true|none|none|
|id|string|true|none|merchant id from the POST /merchant call|

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
		"contact_closed": 1
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
		"contact_closed": 1
	},
	"id": "045b35f5-aed8-4c75-97f9-942de0fc0c32",
	"trigger_id": 20,
	"trigger_date": "2021-12-08T21:39:00.349754Z",
	"event_id": "46d91344-cc41-4922-b00f-c40226b548a4",
	"message": "",
	"expires": "2021-12-09T21:39:00.349475Z"
}
```

Amex Update Webhook

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
