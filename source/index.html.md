
# eVoke

I can write the introduction here

## Indices

* [Admin](#admin)

  * [Get Partners](#1-get-partners)
  * [New Merchant](#2-new-merchant)
  * [New Merchant Location](#3-new-merchant-location)
  * [New Partner](#4-new-partner)
  * [Save Merchant](#5-save-merchant)
  * [Save Merchant Location](#6-save-merchant-location)
  * [Save Partner Webhooks](#7-save-partner-webhooks)

* [Cyberdyne](#cyberdyne)

  * [Get Latest Webhook Data](#1-get-latest-webhook-data)

* [Partner Admin](#partner-admin)

  * [Get Authenticated Partner](#1-get-authenticated-partner)
  * [Get Terminals](#2-get-terminals)
  * [Get Terminals By Location](#3-get-terminals-by-location)
  * [New Terminal](#4-new-terminal)
  * [Terminal Terminal Connection Status](#5-terminal-terminal-connection-status)
  * [Update Terminal](#6-update-terminal)

* [Ungrouped](#ungrouped)

  * [Cancel](#1-cancel)
  * [Cancel Results](#2-cancel-results)
  * [Charge](#3-charge)
  * [Charge Results](#4-charge-results)
  * [Customer Token Charge](#5-customer-token-charge)
  * [Get Location Sales](#6-get-location-sales)
  * [Get Merchant Sales](#7-get-merchant-sales)
  * [Get Partner Sales](#8-get-partner-sales)
  * [Get Sale Receipt](#9-get-sale-receipt)
  * [Get Terminal by Serial Number](#10-get-terminal-by-serial-number)
  * [Get Transaction Receipt](#11-get-transaction-receipt)
  * [Health Check](#12-health-check)
  * [Refund](#13-refund)
  * [Refund Results](#14-refund-results)
  * [Signature](#15-signature)
  * [Signature Results](#16-signature-results)


--------


## Admin
Here we can write folder level descriptions



### 1. Get Partners



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/partners
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| AdminToken | {{AdminToken}} |  |



### 2. New Merchant



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/partners/9741906f-450d-4613-9e66-88b64fed1cef/merchants
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| AdminToken | {{AdminToken}} |  |



***Body:***

```js        
{
    "Name": "Ben Merchant",
    "logoUrl": "https://4.bp.blogspot.com/-h1kPOCO_2yU/URx6dREPfkI/AAAAAAAAATk/sWkVlA1nID8/s1600/stencil-superman-logo-thanks-to-eli-kennedy-manofsteel-utk-edu-67675.jpg",
    "foregroundColor": "EE422A",
    "backgroundColor": "010084",
    "font": "Vernada",
    "phone": "1231231234",
    "email": "ben@superman.com"
}
```



### 3. New Merchant Location



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/partners/8df37185-3c6a-44c6-9833-5ae532ecd74c/merchants/17c3cd75-c2e2-4b40-a227-552f115483c4/locations
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| AdminToken | {{AdminToken}} |  |



***Body:***

```js        
{
    "name": "Ben Testerrrrrrrrrrr Location",
    "partnerMerchantLocationId": "1234",
    "address1": "123 superman st",
    "address2": null,
    "city": "san diego",
    "state": "ca",
    "zip": "92081",
    "countryCode": "US"
}
```



### 4. New Partner



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/partners
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| AdminToken | {{AdminToken}} |  |



***Body:***

```js        
{
    "Name":"Cyberdyne"
}
```



### 5. Save Merchant



***Endpoint:***

```bash
Method: PUT
Type: RAW
URL: {{eVokeUrl}}/partners/9741906f-450d-4613-9e66-88b64fed1cef/merchants/2dcfb69a-c058-4a57-8bd9-520ce43e962a
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| AdminToken | {{AdminToken}} |  |



***Body:***

```js        
{
    "Name": "Ben Merchant",
    "logoUrl": "https://4.bp.blogspot.com/-h1kPOCO_2yU/URx6dREPfkI/AAAAAAAAATk/sWkVlA1nID8/s1600/stencil-superman-logo-thanks-to-eli-kennedy-manofsteel-utk-edu-67675.jpg",
    "foregroundColor": "EE422A",
    "backgroundColor": "010084",
    "font": "Vernada",
    "phone": "1231231234",
    "email": "ben@superman.com"
}
```



### 6. Save Merchant Location



***Endpoint:***

```bash
Method: PUT
Type: RAW
URL: {{eVokeUrl}}/partners/8df37185-3c6a-44c6-9833-5ae532ecd74c/merchants/17c3cd75-c2e2-4b40-a227-552f115483c4/locations/e01cdd36-9682-4ed7-994d-fe078b922813
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| AdminToken | {{AdminToken}} |  |



***Body:***

```js        
{
    "name": "Ben Merchant Locatzzzzzzzzzzzzzzzzzzzzzzzzzzzzzion",
    "partnerMerchantLocationId":"1234",
    "address1": "123 superman st",
    "address2": null,
    "city": "san diego",
    "state": "ca",
    "zip": "92081",
    "countryCode": "US"
}
```



### 7. Save Partner Webhooks



***Endpoint:***

```bash
Method: PUT
Type: RAW
URL: {{eVokeUrl}}/partners/9741906f-450d-4613-9e66-88b64fed1cef/webhooks
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| AdminToken | {{AdminToken}} |  |



***Body:***

```js        
[
    {
        "WebhookType":"Webhook.Transaction.Completed",
        "Url":"http://localhost:7071/api/Cyberdyne/TransactionCompleted"
    },
     {
        "WebhookType":"Webhook.Terminal.Connection.Changed",
        "Url":"http://localhost:7071/api/Cyberdyne/ConnectionChanged"
    }
]
```



## Cyberdyne



### 1. Get Latest Webhook Data



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/cyberdyne/webhookdata
```



## Partner Admin



### 1. Get Authenticated Partner



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/partners/authenticated
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 2. Get Terminals



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/terminals
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 3. Get Terminals By Location



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/merchants/6f0ae398-7da0-4e93-a00c-905a1d7188c3/locations/7e3b6bfb-8369-4a8a-acce-4ce1e5d6a029/terminals
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 4. New Terminal



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/terminals
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



***Body:***

```js        
{
    "Name":"Ben's A920",
    "SerialNumber":"0820557259",
    "TerminalType":"Terminals.PAX.A920"
}
```



### 5. Terminal Terminal Connection Status



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/terminals/0820557259/status
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 6. Update Terminal



***Endpoint:***

```bash
Method: PUT
Type: RAW
URL: {{eVokeUrl}}/terminals/{{TerminalSerialNumber}}
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



***Body:***

```js        
{
    "Name":"Ben's A920"
}
```



## Ungrouped



### 1. Cancel



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/sale/{{SaleId}}/cancel
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

```js        
{"TerminalSerialNumber":"{{TerminalSerialNumber}}"}
```



### 2. Cancel Results



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/sale/{{SaleId}}/transactions/{{TransactionId}}/completed
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

```js        
{
    "Amount": 101.46,
    "PosTransactionId":"1234",
    "PosTransactionData":"The cancelled data",
    "TransactionType":"Sale.Cancel.Completed"
}
```



### 3. Charge



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/charge
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

```js        
{
    "LineItems":[
        {
            "ImageUrl":"https://www.aberdeenskitchen.com/wp-content/uploads/2016/07/Chorizo-Breakfast-Burritos-8.jpg",
            "Name":"Breakfast Burrito",
            "Quantity":1,
            "Cost":9.99,
            "Sum":9.99
        },
        {
            "ImageUrl":"https://www.fortunefrenzy.co.uk/wp-content/uploads/2016/11/steak-dinner.jpg",
            "Name":"Steak Dinner",
            "Quantity":3,
            "Cost":24.99,
            "Sum":74.97
        }
    ],
    "AmountItems":[
        {
            "Name":"Subtotal",
            "Amount": 84.96
        },
        {
            "Name":"Tax (10%)",
            "Amount": 8.50
        },
        {
            "Name":"Tip",
            "Amount": 5.0
        },
        {
            "Name":"Delivery Fee",
            "Amount": 3.00
        }
    ],
    "Total": 101.46,
    "PartnerCustomerId":"{{$randomUUID}}",
    "PartnerSaleId":"{{$randomUUID}}",
    "PartnerMerchantLocationId":"cyberdyne1234"
}
```



### 4. Charge Results



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/sale/{{SaleId}}/transactions/{{TransactionId}}/completed
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

```js        
{
    "Amount": 101.46,
    "PosTransactionId":"1234",
    "PosTransactionData":"The refunded data",
    "TransactionType":"Sale.Charge.Completed",
    "CustomerToken":"3A6077BF690D6456"
}
```



### 5. Customer Token Charge



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/charge
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

```js        
{
    "LineItems":[
        {
            "ImageUrl":"https://www.aberdeenskitchen.com/wp-content/uploads/2016/07/Chorizo-Breakfast-Burritos-8.jpg",
            "Name":"Breakfast Burrito",
            "Quantity":1,
            "Cost":9.99,
            "Sum":9.99
        },
        {
            "ImageUrl":"https://www.fortunefrenzy.co.uk/wp-content/uploads/2016/11/steak-dinner.jpg",
            "Name":"Steak Dinner",
            "Quantity":3,
            "Cost":24.99,
            "Sum":74.97
        }
    ],
    "AmountItems":[
        {
            "Name":"Subtotal",
            "Amount": 84.96
        },
        {
            "Name":"Tax (10%)",
            "Amount": 8.50
        },
        {
            "Name":"Tip",
            "Amount": 5.0
        },
        {
            "Name":"Delivery Fee",
            "Amount": 3.00
        }
    ],
    "Total": 101.46,
    "PartnerCustomerId":"abc12345",
    "PartnerSaleId":"{{$randomUUID}}",
    "PartnerMerchantLocationId":"cyberdyne1234"
}
```



### 6. Get Location Sales



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/merchants/6f0ae398-7da0-4e93-a00c-905a1d7188c3/locations/7e3b6bfb-8369-4a8a-acce-4ce1e5d6a029/sales
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 7. Get Merchant Sales



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/merchants/6f0ae398-7da0-4e93-a00c-905a1d7188c3/sales
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 8. Get Partner Sales



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/terminals/serialnumbers/0820557259
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 9. Get Sale Receipt



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/partners/96b9f3e7-5c0a-46e3-be3e-e4b2f33f68f9/sales/01b58277-ca20-44c5-8783-1d189e5005c7/receipt
```



### 10. Get Terminal by Serial Number



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/terminalapp/0820557259
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 11. Get Transaction Receipt



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/transactions/cfcd44e9-ef57-40bc-96e7-607e5b20db19/receipt
```



### 12. Health Check



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/health
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 13. Refund



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/sale/{{SaleId}}/refund
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

```js        
{
    "Amount": 50.0
}
```



### 14. Refund Results



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/sale/{{SaleId}}/transactions/{{TransactionId}}/completed
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

```js        
{
    "Amount": 101.46,
    "PosTransactionId":"1234",
    "PosTransactionData":"The refunded data",
    "TransactionType":"Sale.Refund.Completed"
}
```



### 15. Signature



***Endpoint:***

```bash
Method: POST
Type: RAW
URL: {{eVokeUrl}}/signatures
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

```js        
{
    "TerminalSerialNumber":"{{TerminalSerialNumber}}",
}
```



### 16. Signature Results



***Endpoint:***

```bash
Method: POST
Type: FORMDATA
URL: {{eVokeUrl}}/signatures/{{SignatureId}}
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |
| TerminalSerialNumber | {{TerminalSerialNumber}} |  |



***Body:***

| Key | Value | Description |
| --- | ------|-------------|
|  |  |  |



---
[Back to top](#evoke)
> Made with &#9829; by [thedevsaddam](https://github.com/thedevsaddam) | Generated at: 2021-07-21 14:59:48 by [docgen](https://github.com/thedevsaddam/docgen)
