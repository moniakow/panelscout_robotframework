*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}          Chrome
${SIGNINBUTTON}     xpath=/html/body/div/form/div/div[2]/button
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}    xpath=//*[@id='password']
${PAGELOGO}         xpath=//body/div/div[1]/header/div/h6
${REMINDPASSWORDLINK}       xpath=//div[1]/a
${INVALIDPASSINFO}      xpath=//form/div/div[1]/div[3]/span
${LANGDROPDOWNLOGINPG}      xpath=//form/div/div[2]/div
${CHOOSELANGPLLOGINPG}      xpath=//div[3]/ul/li[1]
${CHANGELANGDASHBOARD}      xpath=//ul[2]/div[1]/div[2]/span
${MAINPAGEHYPERLINK}        xpath=//ul[1]/div[1]/div[2]/span
${SIGNOUTBUTTONDASH}        xpath=//ul[2]/div[2]/div[2]/span
${LOGINPGHEADER}        xpath=//*[@id='__next']//div[1]/h5
${ADDNEWPLAYERBUTTON}   xpath=//div[2]/div/div/a/button/span[1]
${LASTCREATEDPLAYERHYPERLINKDASH}       xpath=//div[3]/div/div/a[1]/button/span[1]
${NEWPLAYEREMAILINPUT}     xpath=//div[1]/div/div/input
${NEWPLAYERNAMEINPUT}     xpath=//div[2]/div/div/input
${NEWPLAYERSURNAMEINPUT}     xpath=//div[3]/div/div/input
${NEWPLAYERWEIGHTINPUT}     xpath=//div[5]/div/div/input
${NEWPLAYERHEIGHTINPUT}     xpath=//div[6]/div/div/input
${NEWPLAYERAGEINPUT}     xpath=//div[7]/div/div/input
${NEWPLAYERLEGDROPDOWN}     xpath=//*[@id="mui-component-select-leg"]
${NEWPLAYERSELECTRIGHTLEG}     xpath=//*[@id="menu-leg"]//li[1]
${NEWPLAYERMAINPOSITIONINPUT}     xpath=//div[11]/div/div/input
${NEWPLAYERSELECTDISTRICTDROPDOWN}     xpath=//*[@id="mui-component-select-district"]
${SELECTDISTRICTLODZ}     xpath=//ul/li[5]
${NEWPLAYERSUBMITFORMBUTTON}     xpath=//form/div[3]/button[1]


*** Test Cases ***
Invalid login to the system
    Open Login Page
    Type In Email
    Type In Invalid Password
    Click On The Submit Button
    Assert Invalid Login
    [Teardown]    Close Browser
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]  Close Browser
Change Language to Polish LoginPage
    Open Login Page
    Change Language To Polish LoginPage
    Assert Changed Lang To Polski LoginPage
    [Teardown]  Close Browser
Change Language to Polish Dashboard
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Change Language from Dashboard
    Assert Changed Lang To Polski Dashboard
    [Teardown]  Close Browser
Sign Out From Dashboard
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Click on Sign Out From Dashboard
    Assert Signed Out From Dashboard
    [Teardown]  Close Browser
Submit New Player
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Click on Add New Player Hyperlink
    Type In Email Add Player
    Type In Name Add Player
    Type In Surname Add Player
    Type In Weight Add Player
    Type In Height Add Player
    Type In Age Add Player
    Select Right Leg Add Player
    Type In Main Position Add Player
    Select Lodz District Add Player
    Click On Submit New Player Button
    Click On Main Page Button
    Assert New Player Created
    [Teardown]    Close Browser


*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}        ${BROWSER}
    Title Should Be         Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}       user07@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}    Test-1234
Click on the Submit button
    Click Button        ${SIGNINBUTTON}
    Sleep    10
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be     Scouts panel
    Capture Page Screenshot     alert.png
Type In Invalid Password
    Input Text    ${PASSWORDINPUT}      invalid
Assert Invalid Login
    Wait Until Element Is Visible    ${INVALIDPASSINFO}
    Element Text Should Be      ${INVALIDPASSINFO}      Identifier or password invalid.
    Capture Page Screenshot    invalidlogin.png
Change Language To Polish LoginPage
    Click Element    ${LANGDROPDOWNLOGINPG}
    Click Element    ${CHOOSELANGPLLOGINPG}
    Sleep       2
Assert Changed Lang To Polski LoginPage
    Element Text Should Be    ${REMINDPASSWORDLINK}     Przypomnij hasło
    Capture Page Screenshot    changedlang2PLLoginPage.png
Change Language from Dashboard
    Click Element    ${CHANGELANGDASHBOARD}
Assert Changed Lang To Polski Dashboard
    Element Text Should Be      ${MAINPAGEHYPERLINK}        Strona główna
    Capture Page Screenshot    MainPageDashboardPL.png
Click on Sign Out From Dashboard
    Click Element       ${SIGNOUTBUTTONDASH}
Assert Signed Out From Dashboard
    Wait Until Element Is Visible    ${LOGINPGHEADER}
    Element Text Should Be    ${LOGINPGHEADER}      Scouts Panel
    Capture Page Screenshot    signedoutfromdashboard.png
Click on Add New Player Hyperlink
    Click Element    ${ADDNEWPLAYERBUTTON}
Type In Email Add Player
    Wait Until Element Is Visible    ${NEWPLAYEREMAILINPUT}
    Input Text    ${NEWPLAYEREMAILINPUT}        test1@yahoo.com
Type In Name Add Player
    Input Text    ${NEWPLAYERNAMEINPUT}     Bronek
Type In Surname Add Player
    Input Text    ${NEWPLAYERSURNAMEINPUT}      Bomba
Type In Weight Add Player
    Input Text    ${NEWPLAYERWEIGHTINPUT}       56
Type In Height Add Player
    Input Text    ${NEWPLAYERHEIGHTINPUT}       165
Type In Age Add Player
    Input Text    ${NEWPLAYERAGEINPUT}      21.04.1998
Select Right Leg Add Player
    Click Element    ${NEWPLAYERLEGDROPDOWN}
    Click Element    ${NEWPLAYERSELECTRIGHTLEG}
Type In Main Position Add Player
    Input Text    ${NEWPLAYERMAINPOSITIONINPUT}     standing
Select Lodz District Add Player
    Click Element    ${NEWPLAYERSELECTDISTRICTDROPDOWN}
    Click Element    ${SELECTDISTRICTLODZ}
Click On Submit New Player Button
    Click Button    ${NEWPLAYERSUBMITFORMBUTTON}
Click On Main Page Button
    Click Element    ${MAINPAGEHYPERLINK}
Assert New Player Created
    Wait Until Element Is Visible    ${LASTCREATEDPLAYERHYPERLINKDASH}
    Element Text Should Be    ${LASTCREATEDPLAYERHYPERLINKDASH}     BRONEK BOMBA
    Capture Element Screenshot   ${LASTCREATEDPLAYERHYPERLINKDASH}      newplayersubmitted.png
