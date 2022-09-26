*** Settings ***
Library    convert.py
Library    DocTest.VisualTest    take_screenshots=True    DPI=200
Suite Setup    Generate Test Data

*** Variables ***
${PAYLOAD_DIR}    testdata/payload
${TESTDATA_DIR}    testdata/image
${CANDIDATE_DIR}    testdata/candidate
${MASK_DIR}    testdata/masks

*** Test Cases ***   
Compare Invoice with missing Logo
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_no_logo.pdf

Compare Invoice with missing Logo with mask
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_no_logo.pdf    placeholder_file=${MASK_DIR}/mask_logo.json

Compare Invoice with different amount
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_diffamounts.pdf

Compare Invoice with different amount with mask
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_diffamounts.pdf    placeholder_file=${MASK_DIR}/mask_invoice_amounts.json    

Compare Invoice with moved text
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_moved_text.pdf

Compare Invoice with moved text with move tolerance from PDF Text
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_moved_text.pdf    move_tolerance=20    get_pdf_content=True

Compare Invoice with different date
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_diff_date.pdf

Compare Invoice with different date with mask
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_diff_date.pdf    placeholder_file=${MASK_DIR}/mask_invoice_date.json
*** Keywords ***
Generate Test Data
    Convert Html To Pdf    ${PAYLOAD_DIR}/invoice.html    ${CANDIDATE_DIR}/invoice.pdf
    Convert Html To Pdf    ${PAYLOAD_DIR}/invoice_nologo.html    ${CANDIDATE_DIR}/invoice_no_logo.pdf
    Convert Html To Pdf    ${PAYLOAD_DIR}/invoice_diffamounts.html    ${CANDIDATE_DIR}/invoice_diffamounts.pdf
    Convert Html To Pdf    ${PAYLOAD_DIR}/invoice_moved_text.html    ${CANDIDATE_DIR}/invoice_moved_text.pdf
    Convert Html To Pdf    ${PAYLOAD_DIR}/invoice_diff_date.html    ${CANDIDATE_DIR}/invoice_diff_date.pdf
    # Convert Html To Pdf    ${PAYLOAD_DIR}/sample_nologo.html    ${TESTDATA_DIR}/no_logo.pdf