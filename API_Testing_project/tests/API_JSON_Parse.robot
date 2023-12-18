*** Settings ***
Documentation    Using the following libraries to perform basic API testing
Library    Collections
Library    JSONLibrary
Library    RequestsLibrary


*** Variables ***
${USER_ID}=    1
${ID}=    1
${TITLE}=    sunt aut facere repellat provident occaecati excepturi optio reprehenderit
${json_test}=    {"id": 1, "title": "Sample Title", "body": "Sample Body", "userId": 1}


*** Test Cases ***
Parse and Verify JSON Structure
    [Documentation]    Create a JSON and verify the structure
    ${body_json}=    Create Dictionary   body_userId=1    body_id=1    body_title=sunt aut facere repellat provident occaecati excepturi optio reprehenderit
    ${response_userId}=    Get From Dictionary    ${body_json}    body_userId
    ${response_id}=    Get From Dictionary    ${body_json}    body_id
    ${response_title}=    Get From Dictionary    ${body_json}    body_title

    Should Be Equal As Strings    ${response_userId}    ${USER_ID}
    Should Be Equal As Strings    ${response_id}    ${ID}
    Should Be Equal As Strings    ${response_title}    ${TITLE}

Handle JSON Response from API
    [Documentation]    Send a request to an API, receive a JSON response, and parse it
    ${response}=    GET    https://jsonplaceholder.typicode.com/posts/1
    ${body_json}=    Set Variable    ${response.json()}
    ${response_userId}=    Get From Dictionary    ${body_json}    userId
    ${response_id}=    Get From Dictionary    ${body_json}    id
    ${response_title}=    Get From Dictionary    ${body_json}    title

    Should Be Equal As Strings    ${response_userId}    ${USER_ID}
    Should Be Equal As Strings    ${response_id}    ${ID}
    Should Be Equal As Strings    ${response_title}    ${TITLE}

Display Last JSON Of List
    [Documentation]    Dynamically display the data of the last JSON entry of the list
    ${response}=    GET    https://jsonplaceholder.typicode.com/posts
    ${body}=    Set Variable    ${response.json()}
    ${last_element}=    Set Variable    ${body}[-1]
    Log    ${last_element}

Log Every ID From List
    [Documentation]    Log every id from the list of JSONs
    ${response}=    GET    https://jsonplaceholder.typicode.com/posts
    ${body}=    Set Variable    ${response.json()}
    @{id_list}=    Create List
    FOR    ${element}    IN    @{body}
        ${id}=    Get From Dictionary    ${element}    id
        Append To List    ${id_list}    ${id}
    END
    # Log out the IDs
    FOR    ${id}    IN    @{id_list}
        Log    ${id}
    END
