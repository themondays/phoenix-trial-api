# Trial API
Welcome to Daviann Trial API with simple JWT (JSON Web Tokens) implementation.
JSON Web Tokens are an open, industry standard RFC 7519 method for representing claims securely between two parties.

## Register new user
Endpoint: `/api/1.0/signup`
Method: POST
Content-Type: application/json
#### JSON request body:
```
{"user": 
	{
		"email": "example@example.com",
		"password": "secret",
		"password_confirmation": "secret"
	}
}
```
#### Response:
Content-Type: application/json
You will get access-token
```
{
	"token": <auth-token>
}
```
## Login
Endpoint: /api/1.0/signin
Method: POST
Data type: Multipart
##### Params:
```
email: <valid email>
password: <valid password>
```
#### Response:
Content-Type: application/json
You will get access-token
```
{
	"token": <auth-token>
}
```
## Get user data
#### Header (required)
Authorization: `Bearer <access-token>`
#### Params/body
not required
#### Response
```
{
	"id": <uuid4-user-id>,
	"email": <user-email>
}
```
## Get user documents
#### Header (required)
Authorization: `Bearer <access-token>`
#### Params/body
not required
#### Response
Content-Type: application/json
```
{
	"data": [
		{
			"title": "Test document",
			"id": "b1384aaf-e4e6-4162-a3c1-d4fbbcc9e12d",
			"file": "asdf.psd"
		},
		{
			"title": "Test document",
			"id": "c2534693-8c41-4a31-873a-1aa1884c3a03",
			"file": "asdf.psd"
		}
		...
	]
}
```
## Get add new document
#### Header (required)
Authorization: `Bearer <access-token>`
#### Params/body (json)
```
{"document": 
	{
		"title": "Sample Title",
		"file": "file name"
	}
}
```
#### Response
Content-Type: application/json
```
{
	"data": [
		{
			"title": "Test document",
			"id": "b1384aaf-e4e6-4162-a3c1-d4fbbcc9e12d",
			"file": "asdf.psd"
		},
		{
			"title": "Test document",
			"id": "c2534693-8c41-4a31-873a-1aa1884c3a03",
			"file": "asdf.psd"
		}
		...
	]
}
```
## Learn more
  * RFC7519: https://tools.ietf.org/html/rfc7519
  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
