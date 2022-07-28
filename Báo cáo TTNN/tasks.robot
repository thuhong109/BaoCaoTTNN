*** Settings ***
Documentation       Template robot main suite.

Library    RPA.Browser.Selenium
Library    RPA.HTTP 
Library    RPA.Excel.Files 
Library    RPA.Tables
Library    RPA.PDF
Library    Collections
Library    RPA.Archive
Library    RPA.Dialogs
Library    RPA.Robocorp.Vault
Library    RPA.FileSystem

*** Variables ***
${Valid_Email}    thuhongabc@gmail.com
${Valid_Password}     123456

*** Keywords ***
Open browser and navigate to website 
    Open Available Browser    https://demo.nopcommerce.com/
    Maximize Browser Window

#     REGISTER
Filling all fields
    Open browser and navigate to website
    Click Element    //a[@class="ico-register"]
    Click Element    //input[@id="gender-male"]
    Input Text    //input[@id="FirstName"]    Thu
    Input Text    //input[@id="LastName"]    Hong
    Select From List By Label    //select[@name="DateOfBirthDay"]    10
    Select From List By Label    //select[@name="DateOfBirthMonth"]    September
    Select From List By Label    //select[@name="DateOfBirthYear"]    2001
    Input Text    //input[@id="Email"]    ${Valid_Email}
    Input Text    //input[@id="Company"]    TMA Solutions
    Input Password    //input[@id="Password"]    ${Valid_Password} 
    Input Password    //input[@id="ConfirmPassword"]    ${Valid_Password} 
    Click Button    //button[@id="register-button"]

Left some required fields blank
    Open browser and navigate to website
    Click Element    //a[@class="ico-register"]
    Click Element    //input[@id="gender-male"]
    Input Text    //input[@id="LastName"]    Hong
    Select From List By Label    //select[@name="DateOfBirthDay"]    10
    Select From List By Label    //select[@name="DateOfBirthMonth"]    September
    Select From List By Label    //select[@name="DateOfBirthYear"]    2001
    Input Text    //input[@id="Company"]    TMA Solutions
    Input Password    //input[@id="Password"]    ${Valid_Password} 
    Input Password    //input[@id="ConfirmPassword"]    ${Valid_Password} 
    Click Button    //button[@id="register-button"]

Cannot register 2 accounts with 1 email
    Filling all fields
    Close Browser 
    Filling all fields


#     LOGIN
Login successfully
    Open browser and navigate to website
    Click Element    //a[@class="ico-login"]
    Input Text    //input[@class="email"]    ${Valid_Email}
    Input Password    //input[@class="password"]    ${Valid_Password} 
    Click Button    //button[@class="button-1 login-button"]

No enter password
    Open browser and navigate to website
    Click Element    //a[@class="ico-login"]
    Input Text    //input[@class="email"]    ${Valid_Email}
    Click Button    //button[@class="button-1 login-button"]


*** Tasks ***
#     REGISTER
TC01. Register successfully - Filling all fields
    Filling all fields
    Sleep    3
    
TC02. Register unsuccessfully - Left some required fields blank
    Left some required fields blank
    Sleep    3

TC03. Verify that user cannot register 2 accounts with 1 email
    Cannot register 2 accounts with 1 email
    Screenshot    //div[@class="master-wrapper-page"]   ${OUTPUT_DIR}${/}TC03_report.png
    Sleep    3

#     LOGIN
TC04. Login successfully - Enter the right value
    Login successfully
    Sleep    3

TC05. Login unsuccessfully - No enter password
    No enter password
    Screenshot    //div[@class="master-wrapper-page"]   ${OUTPUT_DIR}${/}TC05_report.png
    Sleep    3

TC06. Verify that after click remember me, users do not need to login when re-opening the website
    Open browser and navigate to website
    Click Element    //a[@class="ico-login"]
    Input Text    //input[@class="email"]    ${Valid_Email}
    Input Password    //input[@class="password"]    ${Valid_Password}
    Select Checkbox    //input[@id="RememberMe"]
    Sleep    2
    Click Button    //button[@class="button-1 login-button"]
    Sleep    30
    # Close Browser    
    # # Open Headless Chrome Browser   https://demo.nopcommerce.com/
    # Open browser and navigate to website 
    # Sleep    3



#     ADD TO CART
TC07. Add product to cart successfully - From category
    Login successfully
    Click Link    //a[@href="/electronics"]
    Wait Until Element Is Visible    //a[@href="/electronics"]
    Click Element    //a[@title="Show products in category Cell phones"]
    Click Button    (//button[@class="button-2 product-box-add-to-cart-button"])[1]
    Sleep    3

TC08. Add product to cart successfully - From wishlist
    Login successfully
    Click Link    //a[@href="/books"]
    Wait Until Element Is Visible    //a[@href="/books"]
    Click Button    (//button[@class="button-2 add-to-wishlist-button"])[1]
    Click Link    //a[@href="/wishlist"]
    Select Checkbox    //input[@name="addtocart"]
    Click Button    //button[@class="button-2 wishlist-add-to-cart-button"]
    Sleep    3

TC09. Add product to cart unsuccessfully - Unavailable product 
    Login successfully
    Click Link    //a[@href="/apparel"]
    Wait Until Element Is Visible    //a[@href="/customer/info"]
    Click Element    //a[@title="Show products in category Accessories"]
    Click Button    (//button[@class="button-2 product-box-add-to-cart-button"])[3]
    Sleep    2
    Screenshot    //div[@class="master-wrapper-page"]   ${OUTPUT_DIR}${/}TC09_report.png
    Click Element    //span[@class="close"]
    Click Element    //span[@class="cart-label"]
    Sleep    3

TC10. Add product to cart unsuccessfully - Ordering more than the existing quantity of the product
    Login successfully
    Click Link    //a[@href="/apparel"]
    Wait Until Element Is Visible    //a[@href="/customer/info"]
    Click Element    //a[@title="Show products in category Accessories"]
    Click Link    //a[@href="/ray-ban-aviator-sunglasses"]
    Wait Until Element Is Visible    //input[@aria-label="Enter a quantity"]
    Input Text    //input[@aria-label="Enter a quantity"]    100000
    Click Button    //button[@id="add-to-cart-button-33"]
    Sleep    5
    Click Element When Visible    //span[@class="close"]
    Click Element When Visible   //span[@class="cart-label"]
    Sleep    3
