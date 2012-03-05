# Dossier

Dossier is a Ruby on Rails application that stores files. It is meant to store files from multiple systems in a very simple way. Files are attached to a source system, an owner and an uploader. All other information about the files is held in tags.

Dossier does not have a user interface. It is API only.

## API

All API calls are available in JSON and XML formats.

### API Key
Every application that interacts with Dossier must use an API key. This api key must be sent over as a request header with the key `x-api-key`. 


#### List documents

- Path: /documents
- Method: GET
- Parameters: None
- cURL example: `curl -X GET -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" http://example.com/documents.xml`

#### Filter documents by tag

- Path: /documents
- Method: GET
- Parameters: tags=(comma separated list of tag ids or tag names), operator='and' is the default and returns documents that have all the tags specified, 'or' can be specified and returns documents that have at least one of the tags specified)
- cURL example: `curl -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" -F "tags=1,cool" -F "operator=or" http://example.com/documents.json`

#### List documents owned by a user

- Path: /owners/:owner_id/documents
- Method: GET
- Parameters: same as those listed for Filter documents by tag
- cURL example: `curl -X GET -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" http://example.com/owners/234980/documents.json`

#### Get a single document

- Path: /documents/:document_id
- Method: GET
- Parameters: none
- cURL examples: `curl -X GET -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" http://example.com/documents/1.xml`

#### Retrieve the raw file associated with a document

- Path: /documents/:document_id/file
- Method: GET
- Parameters: none
- cURL example: `curl -X GET -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" http://example.com/documents/2/file`

#### Tag a document

- Path: /documents/:document_id/tags
- Method: POST
- Parameters: name=(name of tag) or id=(id of tag)
- cURL example: `curl -X POST -F "name=cool" -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" http://example.com/documents/1/tags.json`

#### Untag a document

- Path: /documents/:document_id/tags/:tag_id_or_name
- Method: DELETE
- Parameters: none
- cURL example: `curl -X DELETE -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" http://example.com/documents/1/tags/cool.json`

#### Create a document

- Path: /documents
- Method: POST
- Parameters: document[owner_id]=(id of owner), document[uploader_id]=(id of uploader), document[file]=(the file)
- cURL example: `curl -X POST -F "document[owner_id]=345346" -F "document[uploader_id]=2345625" -F "document[file]=@/path/to/file/example.txt" -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" http://example.com/documents.json`

#### Delete a document

- Path: /documents/:document_id
- Method: DELETE
- Parameters: none
- cURL example: `curl -X DELETE -H "x-api-key:72356d35079246030db0f76802811ef153fa06dc" http://example.com/documents/2.json`
