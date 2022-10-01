*** Settings ***
Library    DocTest.PdfTest
Library    DocTest.VisualTest

*** Variables ***
${PAYLOAD_DIR}    testdata/payload
${TESTDATA_DIR}    testdata/image
${CANDIDATE_DIR}    testdata/candidate
${MASK_DIR}    testdata/masks

*** Test Cases ***
Check Text Content From PDF
    ${expected_strings}    Create List    Website design    Acme Corp.
    PDF Should Contain Strings    ${expected_strings}    ${TESTDATA_DIR}/invoice.pdf
    Run Keyword And Expect Error    Some expected texts were not found in document
    ...    PDF Should Contain Strings    Does not exist    ${TESTDATA_DIR}/invoice.pdf        
       
Compare Text of PDF Documents with different amounts
    Compare Pdf Documents    ${TESTDATA_DIR}/invoice.pdf     ${CANDIDATE_DIR}/invoice_diffamounts.pdf    compare=text

Get Text From PDF File
    ${text}    Get Text From Document    ${TESTDATA_DIR}/invoice.pdf