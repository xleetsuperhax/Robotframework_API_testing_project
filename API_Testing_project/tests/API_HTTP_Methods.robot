*** Settings ***
Documentation    Using the following libraries to perform basic HTTP Methods testing
Library    JSONLibrary
Library    RequestsLibrary


*** Variables ***
${FIRST_NAME}=    John
${LAST_NAME}=    Jones
${AGE}=    36
${FAV_ANIMAL}=    Dog


*** Test Cases ***
Validate GET
    [Documentation]    Send a GET-call to server and analyze the content of the body
    ${response}=    GET    http://httpbin.org/get
    Should Be Equal As Strings    ${response.status_code}    200
    ${body}=    Convert To String    ${response.content}
    Should Contain    ${body}   http://httpbin.org/get

Validate POST
    [Documentation]    Send body via POST-call and validate status code 200
    ${body}=    Create Dictionary    FirstName=${FIRST_NAME}
    ...    LastName=${LAST_NAME}
    ...    Age=${AGE}    
    ...    FavAnimal=${FAV_ANIMAL}
    ${response}=    POST    http://httpbin.org/post   ${body}
    Should Be Equal As Strings    ${response.status_code}    200

Validate PUT
    [Documentation]    Send body via PUT-call and validate status code 200
    ${body}=    Create Dictionary    FirstName=${FIRST_NAME}
    ...    LastName=${LAST_NAME}
    ...    Age=${AGE}    
    ...    FavAnimal=${FAV_ANIMAL}
    ${response}=    PUT    http://httpbin.org/put   ${body}
    Should Be Equal As Strings    ${response.status_code}    200

Validate DELETE
    [Documentation]    Send a DELETE-call and validate status code 200
    ${response}=    DELETE    http://httpbin.org/delete
    Should Be Equal As Strings   ${response.status_code}    200
    Log    ${response.status_code}
    Log    ${response.content}
    # Should Not Contain    ${response.content}   Accept-Language

Validate PATCH
    [Documentation]    Send body via PATCH-call and validate status code 200
    ${body}=    Create Dictionary    FirstName=${FIRST_NAME}
    ...    LastName=${LAST_NAME}
    ...    Age=${AGE}    
    ...    FavAnimal=${FAV_ANIMAL}
    ${response}=    PATCH   https://httpbin.org/patch    ${body}
    Should Be Equal As Strings    ${response.status_code}    200
