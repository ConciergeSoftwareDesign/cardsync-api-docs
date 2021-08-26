
# eVoke Partner

# eVoke Api Documentation

### Overview
The eVoke API allows you to remotely invoke a credit card transaction on a PAX device from another system.  If you have not already, please contact the Paylani team to become an onboarded partner.

During the onboarding process, your partner account will be given an application token, merchant Id(s), and Merchant Location Id(s).

Please substitute these values with the api documentation variables as follows:
**{{PartnerId}}** = your eVoke assigned partner id
**{{MerchantId}}** = The eVoke assigned merchant id.
**{{MerchantLocationId}}** = The eVoke assigned merchant location id.
**{{TerminalSerialNumber}}** = The Pax terminal serial number (usually found on the back of your pax device)
**{{SaleId}}** = The eVoke assigned sale id (generated after initiating a charge transaction)
**{{TransactionId}}** = The eVoke assigned transaction id (generated after initiating any transaction)
**{{ApplicationToken}}** = Your eVoke assigned partner application token
**{{eVokeUrl}}** = The environment specific api url:
* **Development: https://evokeapi-dev.azurewebsites.net/api**
* **Production: https://evokeapi.azurewebsites.net/api**

**The postman collection representing this api documentation can be found here: https://www.getpostman.com/collections/8ad516d3327e4c7ad32a**

#### Headers
All endpoints require the ApplicationToken header key and corresponding {{ApplicationToken}} value.
The Charge, Cancel, Refund, and Signature endpoints require the TerminalSerialNumber header key and corresponding {{TerminalSerialNumber}} value.

#### Sales and Transactions
Sales are composed of many transactions, with contextual details from the starting charge transaction.


------------


### Charging a card (Charge endpoint)
#### Instructions:
To initiate a card charge transaction, call the {{evokeUrl}}/charge endpoint.  If you would like to include basic information to enhance the user experience in the pax terminal, you may optionally include line items and/or amount items.

**The only required field to initiate a charge is the "Total" field**

#### Custom associated values
These values will be associated with the sale lifecycle, for tracking or associating a partner specific internal identifier.

If you would like to track the contextual sale using an internal partner specific id association, you may optionally set the "PartnerSaleId" variable to your custom identifier.  

To track the associated merchant location id, you may optionally set the "PartnerMerchantLocationId"

#### Customer Card Tokenization
Similar to the custom associated values above, if you would like to store the customer's card as a token, which will not require a card to be used, and instead will operate on the tokenized card, include the partner specific internal customer id in the "PartnerCustomerId" field.

### Refunding a previous charge (POST Refund endpoint)
Specify the {{SaleId}} in the url, and the amount to refund in the body.

### Cancelling a previous charge (POST Cancel endpoint)
Specify the {{SaleId}} in the url to cancel the sale (a void or refund will be used depending if the transaction has already been processed on the specified terminal)

### Requesting a signature (POST Signature endpoint)
Use this endpoint if you would only like to request a signature and nothing else.

### GET Terminals endpoint
Returns the current onboarded terminals, and their connection status

### GET Merchant Sales endpoint
Returns merchant sales

### GET location Sales endpoint
Returns location sales

### GET Sale Receipt endpoint
Returns html sale receipt

### GET Transaction Receipt endpoint
Returns html transaction receipt

## Indices

* [Miscellaneous](#miscellaneous)

  * [Get Terminals](#1-get-terminals)
  * [Signature](#2-signature)

* [Reporting](#reporting)

  * [Get Location Sales](#1-get-location-sales)
  * [Get Merchant Sales](#2-get-merchant-sales)

* [Transactions](#transactions)

  * [Cancel](#1-cancel)
  * [Charge](#2-charge)
  * [Customer Token Charge](#3-customer-token-charge)
  * [Get Sale Receipt](#4-get-sale-receipt)
  * [Get Transaction Receipt](#5-get-transaction-receipt)
  * [Refund](#6-refund)


--------


## Miscellaneous



### 1. Get Terminals



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



### 2. Signature



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
{}
```



## Reporting



### 1. Get Location Sales



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/merchants/{{merchantId}}/locations/{{LocationId}}/sales
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



### 2. Get Merchant Sales



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/merchants/{{merchantId}}/sales
```


***Headers:***

| Key | Value | Description |
| --- | ------|-------------|
| ApplicationToken | {{ApplicationToken}} |  |



## Transactions



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
{}
```



### 2. Charge



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
    "PartnerSaleId":"MyOptionalSaleId-{{$randomUUID}}",
    "PartnerMerchantLocationId":"MyOptionalMerchantLocationId-{{$randomUUID}}"
}
```



### 3. Customer Token Charge



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
    "PartnerCustomerId":"MyOptionalCustomerId-{{$randomUUID}}",
    "PartnerSaleId":"MyOptionalSaleId-{{$randomUUID}}",
    "PartnerMerchantLocationId":"MyOptionalMerchantLocationId-{{$randomUUID}}"
}
```



### 4. Get Sale Receipt



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/partners/{{partnerId}}/sales/{{saleId}}/receipt
```



### 5. Get Transaction Receipt



***Endpoint:***

```bash
Method: GET
Type: RAW
URL: {{eVokeUrl}}/transactions/{{transactionId}}/receipt
```



### 6. Refund



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



---
[Back to top](#evoke-partner)
> Made with &#9829; by [thedevsaddam](https://github.com/thedevsaddam) | Generated at: 2021-08-18 13:06:46 by [docgen](https://github.com/thedevsaddam/docgen)
