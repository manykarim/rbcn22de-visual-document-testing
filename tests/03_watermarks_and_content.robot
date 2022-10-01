*** Settings ***
Library    DocTest.VisualTest    take_screenshots=True    show_diff=True    DPI=72


*** Variables ***
${PAYLOAD_DIR}    testdata/payload
${TESTDATA_DIR}    testdata/image
${CANDIDATE_DIR}    testdata/candidate
${MASK_DIR}    testdata/masks

*** Test Cases ***   
Compare Invoice with Watermark
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${TESTDATA_DIR}/invoice_with_watermark.pdf

Compare Invoice with Watermark and Watermark File
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${TESTDATA_DIR}/invoice_with_watermark.pdf    watermark_file=${MASK_DIR}/rf_watermark.pdf

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

Compare Invoice with moved text with visual move tolerance
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_moved_text.pdf    move_tolerance=20

Compare Invoice with different date
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_diff_date.pdf

Compare Invoice with different date with mask
    Compare Images    ${TESTDATA_DIR}/invoice.pdf    ${CANDIDATE_DIR}/invoice_diff_date.pdf    placeholder_file=${MASK_DIR}/mask_invoice_date.json