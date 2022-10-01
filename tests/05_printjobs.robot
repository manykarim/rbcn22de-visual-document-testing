*** Settings ***
Library    DocTest.VisualTest    take_screenshots=True        DPI=72
Library    DocTest.PrintJobTests


*** Variables ***
${PAYLOAD_DIR}    testdata/payload
${TESTDATA_DIR}    testdata/image
${CANDIDATE_DIR}    testdata/candidate
${MASK_DIR}    testdata/masks

*** Test Cases ***
Visually Compare Two PCL Invoices with missing Logo
    Compare Images    ${TESTDATA_DIR}/invoice.pcl    ${TESTDATA_DIR}/invoice_no_logo.pcl

Visually Compare Two PCL Invoices with missing Logo and mask
    Compare Images    ${TESTDATA_DIR}/invoice.pcl    ${TESTDATA_DIR}/invoice_no_logo.pcl    placeholder_file=${MASK_DIR}/mask_logo.json

Compare content of two PCL Print Jobs with same metadata
    Compare Print Jobs    pcl    ${TESTDATA_DIR}/invoice.pcl    ${TESTDATA_DIR}/invoice_no_logo.pcl

Compare content of two PCL Print Jobs with diff metadata
    Compare Print Jobs    pcl    ${TESTDATA_DIR}/invoice.pcl    ${TESTDATA_DIR}/invoice_letterformat.pcl

Visually Compare Two PCL Invoices with same visuals but different metadata
    Compare Images    ${TESTDATA_DIR}/invoice.pcl    ${TESTDATA_DIR}/invoice_difftray.pcl

Compare content of two PCL Print Jobs with same visuals but different metadata
    Compare Print Jobs    pcl    ${TESTDATA_DIR}/invoice.pcl    ${TESTDATA_DIR}/invoice_difftray.pcl