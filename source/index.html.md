---
title: CardSync Amex Card Account Updater 
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

<h1 id="cardsync-amex-card-account-updater">CardSync Amex Card Account Updater</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

This is the API for the CardSync Universal Account service.

After signing up as a CardSync Partner, you will be able to use this API in sandbox and production. You will be provided with an API key and a Partner Billing Identifier.

This API allows Partners to create and enroll Merchants and submit inquiry batches of credit card numbers and expiration dates to obtain card status (including updates to card numbers and/or expiration dates) or status updates.

Here are the set of steps needed to create and enroll a merchant:

1. Create merchant with /merchant POST. Depending on the agreement between the Partner and the Merchant, Terms of Service may need to be displayed. If this is the case, set "accept_tos" to "false". If the Terms have already been agreed to by the merchant, set "accept_tos" to "true".
2. Retrieve and save provided "id" and "api_key".
3. (Optional) If the merchant needs to agree to additional Terms of Service, display the Terms of Service so the merchant can sign the legal documentation. This step is optional as your existing agreement with the Merchant may already include these terms. If the Terms are required, call /accept-tos once the Merchant has signed. using the "id" as "account_type_id" and the "api_key" saved in step 2. This API call is not needed if "accept_tos" was set to "true" in step 1.
4. (Optional) If a merchant abandons the process, it can be resumed upon next login by presenting the "agreement_url" again.
5.  Create merchant enrollment with /enrollment POST, using "api_key" from step 2.
6. The merchant will be set up for the Account Updater Service within 5-7 business days. The status can be retrieved via GET /enrollment.
7. Once enrolled, batches can be submitted via the /batch POST. Save the provided "batch_id".
8. Check batch status with GET /batch/{batch_id}.
9. When the batch status is complete, retrieve the results with GET /batch/{batch_id}/results. Batches take approximately 5 business days to complete.

Each batch may consist of up to 10,000 card numbers. There is no limit on the number of consecutive batch submissions. Inquiries may return one of six responses: updated_card, updated_expiry, no_match, valid, contact, or contact_closed. If the response is updated_card or updated_expiry, the updated card information is returned. Otherwise, one of the other four status types is returned. Some card inquiries do not result in any status type. This generally means the card is valid.

For more information, visit https://cardsync.io.

Contact Support:  
    Email: help@cardsync.io

Base URLs:

* <a href="https://sandbox.cardsync.io/api">https://sandbox.cardsync.io/api</a>

# Authentication

* API Key (Authorization)
    - Parameter Name: **Authorization**, in: header. 

<h1 id="cardsync-amex-card-account-updater-merchant">Merchant</h1>

Merchants are top level entities that must be created for Universal Account Updater enrollment by the respective Card Brands. Use the master api_key provided to you during your account creation for this call.

This call will return a new, merchant-level api_key. This new api_key should be used for all future requests associated with the newly created merchant.

During the merchant creation process, you can optionally display Terms of Service (TOS) for the merchant to accept. If the TOS has already been incorporated into your agreement with the merchant, you may skip this step.

If you want the TOS, please set the "accept_tos" flag to "false" when calling the /merchant POST. If you set it to true, the merchant creation will happen immediately. If you set accept_tos to false, you can then call /accept-tos after the merchant has accepted the TOS.

## Add New Merchant

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
  "name": "New Merchant <name must be unique>",
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
  "accept_tos": true
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

This endpoint is used to create a new Merchant on our platform. The details provided will be used later to auto fill the enrollment agreement. Merchants must have a unique name. The fee_schedule_id will be provided to you during your Partner creation and will be the same for all Merchants you create.

> Body parameter

```json
{
  "name": "New Merchant <name must be unique>",
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
  "accept_tos": true
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
    "partner_id": "bqgblveg10l2b5dhg0ig",
    "name": "New Merchant",
    "description": "this is a new merchant that is getting setup",
    "website": "example.com",
    "phone": "5555555555",
    "phone_ext": "",
    "receipt_email": "test@example.com",
    "timezone": "UTC",
    "status": "active",
    "fee_schedule_id": "bqgblveg10l2b5dhg0l0",
    "logo_url": "",
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
      "phone": "7177546366",
      "phone_ext": "",
      "fax": "",
      "email": "test@example.com"
    },
    "billing_contact": {
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
    },
    "billing": null,
    "api_key": "api_1auidmDFdMslUz2R5PSwVFSEfmP",
    "tos_accepted_by": "Test Partner / Test Partner",
    "tos_accepted_by_username": "test_partner",
    "created_at": "2020-04-22T21:46:08.448148Z",
    "tos_last_accepted_at": "2020-04-22T21:46:08Z"
  }
}
```

<h3 id="add-a-new-merchant-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Merchant Response](#schemaaddanewmerchantresponse)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

## Accept Terms of Service

<a id="opIdAcceptTermsofService"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/api/accept-tos \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json; charset=utf-8' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/api/accept-tos HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json; charset=utf-8

```

```javascript
const inputBody = '{
  "name": "Signor Name1",
  "title": "Title1",
  "account_type": "merchant",
  "account_type_id": "c0lbt59erttvtfnb7k0g <id from /merchant>",
  "type": "cardsync",
  "version": 2
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json; charset=utf-8',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/api/accept-tos',
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
  'Accept' => 'application/json; charset=utf-8',
  'Authorization' => 'API_KEY'
}

result = RestClient.post 'https://sandbox.cardsync.io/api/accept-tos',
  params: {
  }, headers: headers

p JSON.parse(result)

```

```python
import requests
headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json; charset=utf-8',
  'Authorization': 'API_KEY'
}

r = requests.post('https://sandbox.cardsync.io/api/accept-tos', headers = headers)

print(r.json())

```

```php
<?php

require 'vendor/autoload.php';

$headers = array(
    'Content-Type' => 'application/json',
    'Accept' => 'application/json; charset=utf-8',
    'Authorization' => 'API_KEY',
);

$client = new \GuzzleHttp\Client();

// Define array of request body.
$request_body = array();

try {
    $response = $client->request('POST','https://sandbox.cardsync.io/api/accept-tos', array(
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
URL obj = new URL("https://sandbox.cardsync.io/api/accept-tos");
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
        "Accept": []string{"application/json; charset=utf-8"},
        "Authorization": []string{"API_KEY"},
    }

    data := bytes.NewBuffer([]byte{jsonReq})
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/api/accept-tos", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`POST /accept-tos`

During merchant creation, an enrollment_url is provided which provides the CardSync partner terms. If the Terms of Service are not marked as accepted during the merchant creation API call, the partner may call this API to mark that the merchant has accepted the Terms of Service.

> Body parameter

```json
{
  "name": "Signor Name1",
  "title": "Title1",
  "account_type": "merchant",
  "account_type_id": "c0lbt59erttvtfnb7k0g <id from /merchant>",
  "type": "cardsync",
  "version": 2
}
```

<h3 id="accept-terms-of-service-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[Terms of Service](#schemaaccepttermsofservicerequest)|true|none|

> Example responses

> 200 Response

```json
{
  "status": "success",
  "msg": "success"
}
```

<h3 id="accept-terms-of-service-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Terms of Service Response](#schemaaccepttermsofservice-200ok)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

<h1 id="cardsync-amex-card-account-updater-enrollment">Enrollment</h1>

Once a Merchant has been created, you can initiate the Card Brand Enrollment process using the endpoints below. 

Enrollment will request some additional details around stored card data and will be used to auto fill the Card Brand required CardSync Merchant Agreement. A Merchant should only be enrolled one time.

If you have the Interim Activation feature on your partner account, the merchant account will activate immediately. If this feature is not active, it will take 5-7 business days for the Card Brands to approve the request. You may retrieve the Enrollment Status to determine if the process is complete.

Once the account is active, card batches (see next section) may be submitted immediately.

## Request Enrollment

<a id="opIdRequestEnrollment"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/api/cardsync/enrollment \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/api/cardsync/enrollment HTTP/1.1
Host: sandbox.cardsync.io
Content-Type: application/json
Accept: application/json

```

```javascript
const inputBody = '{
  "legal_business_name": "Offical Corporate Legal Name",
  "type_of_biller": "both",
  "total_number_of_records": 400,
  "number_of_visa": 100,
  "number_of_mastercard": 100,
  "number_of_discover": 100,
  "number_of_amex": 100,
  "delivery_frequency": "monthly",
  "mcc": "5968"
}';
const headers = {
  'Content-Type':'application/json',
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/api/cardsync/enrollment',
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

result = RestClient.post 'https://sandbox.cardsync.io/api/cardsync/enrollment',
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

r = requests.post('https://sandbox.cardsync.io/api/cardsync/enrollment', headers = headers)

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
    $response = $client->request('POST','https://sandbox.cardsync.io/api/cardsync/enrollment', array(
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
URL obj = new URL("https://sandbox.cardsync.io/api/cardsync/enrollment");
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
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/api/cardsync/enrollment", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`POST /cardsync/enrollment`

Request Enrollment for a merchant. 

In order for Partners to enroll their Merchant(s), CardSync must receive the Merchant legal entity name, Merchant Category Code (MCC), and an estimated number of of Visa, MasterCard, Discover, and American Express cards in the Merchant database.

The response to the Request Enrollment contains an "agreement_url" which can be displayed in an iframe to the user for immediate in-line signature.

Once the Card Brands have confirmed a Merchant has been approved and enrolled for Universal Account Updater (up to 5 business days), we will generate a confirmation response. Upon receiving enrollment confirmation via retrieve enrollment status, a partner my begin submitting card inquiries.

> Body parameter

```json
{
  "legal_business_name": "Offical Corporate Legal Name",
  "type_of_biller": "both",
  "total_number_of_records": 400,
  "number_of_visa": 100,
  "number_of_mastercard": 100,
  "number_of_discover": 100,
  "number_of_amex": 100,
  "delivery_frequency": "monthly",
  "mcc": "5968"
}
```

<h3 id="request-enrollment-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[Enrollment](#schemarequestenrollmentrequest)|true|none|

> Example responses

> 200 Response

```json
{
  "status": "success",
  "msg": "success",
  "data": {
    "id": "bqgbm86g10l2fm2bv7n1",
    "type": "cardsync",
    "details": {
      "legal_business_name": "Full Legal Name of Merchant",
      "type_of_biller": "both",
      "total_number_of_records": 400,
      "number_of_visa": 100,
      "number_of_mastercard": 100,
      "number_of_discover": 100,
      "number_of_amex": 100,
      "delivery_frequency": "monthly",
      "mcc": "5968"
    },
    "status": "active",
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z",
    "activated_at": null,
    "deactivated_at": null
  }
}
```

<h3 id="request-enrollment-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Enrollment Response](#schemarequestenrollment-200okactive)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

## Retrieve Enrollment Status

<a id="opIdRetrieveEnrollmentstatus"></a>

> Code samples

```shell
# You can also use wget
curl -X GET https://sandbox.cardsync.io/api/cardsync/enrollment \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/api/cardsync/enrollment HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/api/cardsync/enrollment',
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

result = RestClient.get 'https://sandbox.cardsync.io/api/cardsync/enrollment',
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

r = requests.get('https://sandbox.cardsync.io/api/cardsync/enrollment', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/api/cardsync/enrollment', array(
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
URL obj = new URL("https://sandbox.cardsync.io/api/cardsync/enrollment");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/api/cardsync/enrollment", data)
    req.Header = headers

    client := &http.Client{}
    resp, err := client.Do(req)
    // ...
}

```

`GET /cardsync/enrollment`

Returns the current status of the Merchant's requested enrollment. This will let you know when CardSync has received a completed e-sign document as well as when a Merchant has been activated so you may start submitting card inquiries on their behalf.

> Example responses

> 200 Response

```json
{
  "status": "success",
  "msg": "success",
  "data": {
    "id": "bqgbm86g10l2fm2bv7n1",
    "type": "cardsync",
    "details": {
      "legal_business_name": "test merchant inc",
      "type_of_biller": "both",
      "total_number_of_records": 400,
      "number_of_visa": 100,
      "number_of_mastercard": 100,
      "number_of_discover": 100,
      "number_of_amex": 100,
      "delivery_frequency": "monthly",
      "mcc": "5968"
    },
    "status": "active",
    "created_at": "2020-04-22T21:46:08.448148Z",
    "updated_at": "2020-04-22T21:46:08.448148Z",
    "activated_at": "2020-04-22T21:46:08.448148Z",
    "deactivated_at": null
  }
}
```

<h3 id="retrieve-enrollment-status-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|OK|[Enrollment Status](#schemaretrieveenrollmentstatus-200ok)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
Authorization
</aside>

<h1 id="cardsync-amex-card-account-updater-batch">Batch</h1>

A batch is a set of up to 10,000 credit card numbers and expiration dates being submitted for updates by the respective Card Issuers. If you need to send inquiries on more than 10,000 cards at once, you may submit multiple batches simultaneously.

Best practice for recurring billing (e.g. subscriptions) is to submit on a daily or weekly basis any cards being billed in the next one to two weeks. For Merchants with payment data on file, we recommend submitting those based on your average time between transactions.

Once submitted, the Card Issuers will start to return updates. In sandbox, all results (updates and/or status responses) are completed within one hour. In production, it will take 3-5 calendar days for a batch to complete. 

## Create Card Batch

<a id="opIdCreatesbatchofcardsforupdates"></a>

> Code samples

```shell
# You can also use wget
curl -X POST https://sandbox.cardsync.io/api/cardsync/batch \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
POST https://sandbox.cardsync.io/api/cardsync/batch HTTP/1.1
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

fetch('https://sandbox.cardsync.io/api/cardsync/batch',
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

result = RestClient.post 'https://sandbox.cardsync.io/api/cardsync/batch',
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

r = requests.post('https://sandbox.cardsync.io/api/cardsync/batch', headers = headers)

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
    $response = $client->request('POST','https://sandbox.cardsync.io/api/cardsync/batch', array(
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
URL obj = new URL("https://sandbox.cardsync.io/api/cardsync/batch");
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
    req, err := http.NewRequest("POST", "https://sandbox.cardsync.io/api/cardsync/batch", data)
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
curl -X GET https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID} \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID} HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}',
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

result = RestClient.get 'https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}',
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

r = requests.get('https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}', array(
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
URL obj = new URL("https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}", data)
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
curl -X GET https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}/results \
  -H 'Accept: application/json' \
  -H 'Authorization: API_KEY'

```

```http
GET https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}/results HTTP/1.1
Host: sandbox.cardsync.io
Accept: application/json

```

```javascript

const headers = {
  'Accept':'application/json',
  'Authorization':'API_KEY'
};

fetch('https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}/results',
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

result = RestClient.get 'https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}/results',
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

r = requests.get('https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}/results', headers = headers)

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
    $response = $client->request('GET','https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}/results', array(
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
URL obj = new URL("https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}/results");
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
    req, err := http.NewRequest("GET", "https://sandbox.cardsync.io/api/cardsync/batch/{BATCH_ID}/results", data)
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

<h2 id="tocS_AddanewmerchantRequest">Merchant</h2>
<!-- backwards compatibility -->
<a id="schemaaddanewmerchantrequest"></a>
<a id="schema_AddanewmerchantRequest"></a>
<a id="tocSaddanewmerchantrequest"></a>
<a id="tocsaddanewmerchantrequest"></a>

```json
{
  "name": "New Merchant <name must be unique>",
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
  "accept_tos": true
}

```

Merchant

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|name|string|true|must be globally unique|none|
|description|string|true|none|none|
|website|string|true|none|none|
|phone|string|true|none|none|
|phone_ext|string|true|none|none|
|receipt_email|string|true|none|none|
|timezone|string|true|none|none|
|fee_schedule_id|string|true|none|none|
|primary_contact|[PrimaryContact](#schemaprimarycontact)|true|none|none|
|user|[User](#schemauser)|true|none|none|
|accept_tos|boolean|true|none|none|

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

<h2 id="tocS_Data">Merchant Response</h2>
<!-- backwards compatibility -->
<a id="schemadata"></a>
<a id="schema_Data"></a>
<a id="tocSdata"></a>
<a id="tocsdata"></a>

```json
{
  "id": "bqgbm86g10l2fm2bv7n0",
  "partner_id": "bqgblveg10l2b5dhg0ig",
  "name": "New Merchant",
  "description": "this is a new merchant that is getting setup",
  "website": "example.com",
  "phone": "5555555555",
  "phone_ext": "",
  "receipt_email": "test@example.com",
  "timezone": "UTC",
  "status": "active",
  "fee_schedule_id": "bqgblveg10l2b5dhg0l0",
  "logo_url": "",
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
    "phone": "7177546366",
    "phone_ext": "",
    "fax": "",
    "email": "test@example.com"
  },
  "billing_contact": {
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
  },
  "billing": null,
  "api_key": "api_1auidmDFdMslUz2R5PSwVFSEfmP",
  "tos_accepted_by": "Test Partner / Test Partner",
  "tos_accepted_by_username": "test_partner",
  "created_at": "2020-04-22T21:46:08.448148Z",
  "tos_last_accepted_at": "2020-04-22T21:46:08Z"
}

```

Merchant Response

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|id|string|true|none|none|
|partner_id|string|true|none|none|
|name|string|true|none|none|
|description|string|true|none|none|
|website|string|true|none|none|
|phone|string|true|none|none|
|phone_ext|string|true|none|none|
|receipt_email|string|true|none|none|
|timezone|string|true|none|none|
|status|string|true|none|none|
|fee_schedule_id|string|true|none|none|
|logo_url|string|true|none|none|
|primary_contact|[Primary Contact](#schemaprimarycontact)|true|none|none|
|billing_contact|[Billing Contact](#schemabillingcontact)|true|none|none|
|billing|string¦null|true|none|none|
|api_key|string|true|none|none|
|tos_accepted_by|string|true|none|none|
|tos_accepted_by_username|string|true|none|none|
|created_at|string|true|none|none|
|tos_last_accepted_at|string|true|none|none|

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

<h2 id="tocS_AcceptTermsofServiceRequest">Terms of Service</h2>
<!-- backwards compatibility -->
<a id="schemaaccepttermsofservicerequest"></a>
<a id="schema_AcceptTermsofServiceRequest"></a>
<a id="tocSaccepttermsofservicerequest"></a>
<a id="tocsaccepttermsofservicerequest"></a>

```json
{
  "name": "Signor Name1",
  "title": "Title1",
  "account_type": "merchant",
  "account_type_id": "c0lbt59erttvtfnb7k0g <id from /merchant>",
  "type": "cardsync",
  "version": 2
}

```

Terms of Service

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|name|string|true|none|none|
|title|string|true|none|none|
|account_type|string|true|none|none|
|account_type_id|string|true|none|none|
|type|string|true|none|none|
|version|integer(int32)|true|none|none|

<h2 id="tocS_AcceptTermsofServiceResponse">Terms of Service Response</h2>
<!-- backwards compatibility -->
<a id="schemaaccepttermsofserviceresponse"></a>
<a id="schema_AcceptTermsofServiceResponse"></a>
<a id="tocSaccepttermsofserviceresponse"></a>
<a id="tocsaccepttermsofserviceresponse"></a>

```json
{
  "status": "success",
  "msg": "success"
}

```

Terms of Service Response

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|true|none|none|
|msg|string|true|none|none|

<h2 id="tocS_RequestEnrollmentRequest">Enrollment</h2>
<!-- backwards compatibility -->
<a id="schemarequestenrollmentrequest"></a>
<a id="schema_RequestEnrollmentRequest"></a>
<a id="tocSrequestenrollmentrequest"></a>
<a id="tocsrequestenrollmentrequest"></a>

```json
{
  "legal_business_name": "Offical Corporate Legal Name",
  "type_of_biller": "both",
  "total_number_of_records": 400,
  "number_of_visa": 100,
  "number_of_mastercard": 100,
  "number_of_discover": 100,
  "number_of_amex": 100,
  "delivery_frequency": "monthly",
  "mcc": "5968"
}

```

Enrollment

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|legal_business_name|string|true|none|none|
|type_of_biller|string|true|none|none|
|total_number_of_records|integer(int32)|true|none|none|
|number_of_visa|integer(int32)|true|none|none|
|number_of_mastercard|integer(int32)|true|none|none|
|number_of_discover|integer(int32)|true|none|none|
|number_of_amex|integer(int32)|true|none|none|
|delivery_frequency|string|true|none|none|
|mcc|string|true|none|none|

<h2 id="tocS_Details">Enrollment Response</h2>
<!-- backwards compatibility -->
<a id="schemadetails"></a>
<a id="schema_Details"></a>
<a id="tocSdetails"></a>
<a id="tocsdetails"></a>

```json
{
  "legal_business_name": "Full Legal Name of Merchant",
  "type_of_biller": "both",
  "total_number_of_records": 400,
  "number_of_visa": 100,
  "number_of_mastercard": 100,
  "number_of_discover": 100,
  "number_of_amex": 100,
  "delivery_frequency": "monthly",
  "mcc": "5968"
}

```

Enrollment Response

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|legal_business_name|string|true|none|none|
|type_of_biller|string|true|none|none|
|total_number_of_records|integer(int32)|true|none|none|
|number_of_visa|integer(int32)|true|none|none|
|number_of_mastercard|integer(int32)|true|none|none|
|number_of_discover|integer(int32)|true|none|none|
|number_of_amex|integer(int32)|true|none|none|
|delivery_frequency|string|true|none|none|
|mcc|string|true|none|none|

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