
# eVoke Partner

The eVoke API allows you to invoke a credit card charge on a PAX device from another system.

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
{
    "TerminalSerialNumber":"{{TerminalSerialNumber}}",
}
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
{"TerminalSerialNumber":"{{TerminalSerialNumber}}"}
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
> Made with &#9829; by [thedevsaddam](https://github.com/thedevsaddam) | Generated at: 2021-08-02 06:33:53 by [docgen](https://github.com/thedevsaddam/docgen)
