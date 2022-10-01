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