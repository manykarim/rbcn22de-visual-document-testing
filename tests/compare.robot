*** Settings ***
Library    DocTest.VisualTest    take_screenshots=True    DPI=200
Library    DocTest.PdfTest

*** Test Cases ***
Compare Invoices with missing Logo
    Compare Images    testdata/invoice001.pdf    ${CURDIR}/invoice_nologo.pdf

Compare Invoices with missing Logo with mask
    Compare Images    ${CURDIR}/invoice001.pdf    ${CURDIR}/invoice_nologo.pdf    placeholder_file=${CURDIR}/mask_logo.json

Compare Invoices with missing Logo with watermark file
    Compare Images    ${CURDIR}/invoice001.pdf    ${CURDIR}/invoice_nologo.pdf    watermark_file=${CURDIR}/mask_logo.pdf

Compare Invoices with missing Logo with pixel watermark file
    Compare Images    ${CURDIR}/invoice001.pdf    ${CURDIR}/invoice_nologo.pdf    watermark_file=${CURDIR}/mask_logo_gimp.pdf

Compare Invoices content with missing Logo
    Compare Pdf Documents    ${CURDIR}/invoice001.pdf    ${CURDIR}/invoice_nologo.pdf    compare=text

Compare Invoices different ammounts
    Compare Images    ${CURDIR}/invoice001.pdf    ${CURDIR}/invoice_diffamounts.pdf

Compare Invoices different ammounts with mask
    Compare Images    ${CURDIR}/invoice001.pdf    ${CURDIR}/invoice_diffamounts.pdf    placeholder_file=${CURDIR}/mask_invoice.json
