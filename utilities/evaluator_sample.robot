*** Settings ***
Library    ${CURDIR}/convert.py
Library    OperatingSystem
Library  DocTest.VisualTest    DPI=${DPI}    #watermark_file=${REFERENCE_DIR}${/}watermarks
Library    DataDriver    file=evaluator_sample.xlsx
Library    Collections
Test Template     Compare Documents


*** Variables ***
${REFERENCE_DIR}  ${CURDIR}${/}reference
${CANDIDATE_DIR}  ${CURDIR}${/}..${/}testdata${/}candidate
${PAYLOAD_DIR}  ${CURDIR}${/}..${/}testdata${/}payload
${MASK_DIR}  ${CURDIR}${/}..${/}testdata${/}masks
${DPI}    72

*** Test Cases ***
Create ${payload_file}


*** Keywords ***
Copy Files for Failed Comparison
    [Arguments]    ${payload_file}    ${reference_file}    ${candidate_file}
    ${STATUS}=    Get Variable Value    ${KEYWORD STATUS}    ${TEST STATUS}    
    ${payload_file_path}	${payload_file_name} =	Split Path	${payload_file}
    ${reference_file_path}	${reference_file_name} =	Split Path	${reference_file}
    Run Keyword If    '${STATUS}'=='FAIL'    Run Keyword And Ignore Error    Copy File    ${payload_file}    ${OUTPUT DIR}${/}Failed${/}${TEST NAME}${/}${payload_file_name}
    Run Keyword If    '${STATUS}'=='FAIL'    Run Keyword And Ignore Error    Copy File    ${reference_file}    ${OUTPUT DIR}${/}Failed${/}${TEST NAME}${/}reference_${reference_file_name}
    Run Keyword If    '${STATUS}'=='FAIL'    Run Keyword And Ignore Error    Copy File    ${candidate_file}    ${OUTPUT DIR}${/}Failed${/}${TEST NAME}${/}candidate_${reference_file_name}

Compare Documents
    [Arguments]    ${reference_image}    ${payload_file}    
    ...            ${placeholder_file}    ${check_text_content}     ${move_tolerance}    ${contains_barcodes}     ${get_pdf_content}    ${DPI}    ${retrieve_output}
    [Teardown]    Copy Files for Failed Comparison    
    ...            ${PAYLOAD_DIR}${/}${payload_file}    ${REFERENCE_DIR}${/}${reference_image}     ${candidate_file}
    
    IF     $retrieve_output == 'archive'
        Log    Get Document From Archive
        ${candidate_file}    Get Document From Archive     ${payload_file}    ${CANDIDATE_DIR}
    ELSE IF    $retrieve_output == 'email'
        Log    Get Document Via Email
        ${candidate_file}    Get Document Via Email     ${payload_file}    ${CANDIDATE_DIR}
    ELSE IF    $retrieve_output == 'filesystem'
        Log    Get Document From Filesystem
        ${candidate_file}    Get Document From Filesystem     ${payload_file}    ${CANDIDATE_DIR}
    ELSE IF    $retrieve_output == 'webservice'
        Log    Get Document From WebService
        ${candidate_file}    Get Document From WebService     ${payload_file}    ${CANDIDATE_DIR}
    END
    Compare Images  
    ...    reference_image=${REFERENCE_DIR}${/}${reference_image}  
    ...    test_image=${candidate_file}  
    ...    placeholder_file=${placeholder_file}    
    ...    check_text_content=${check_text_content}    
    ...    move_tolerance=${move_tolerance}    
    ...    contains_barcodes=${contains_barcodes}    
    ...    get_pdf_content=${get_pdf_content}    
    ...    DPI=${DPI}

Get Document From Archive
    [Arguments]    ${payload_file}    ${candidate_dir}
    Log    Get Document From Archive
    ${document}    Convert Html To Pdf    ${PAYLOAD_DIR}/${payload_file}    ${candidate_dir}
    [Return]    ${document}   
Get Document Via Email
    [Arguments]    ${payload_file}    ${candidate_dir}
    Log    Get Document Via Email
    ${document}    Convert Html To Pdf    ${PAYLOAD_DIR}/${payload_file}    ${candidate_dir}
    [Return]    ${document}  
Get Document From Filesystem
    [Arguments]    ${payload_file}    ${candidate_dir}
    Log    Get Document From Filesystem
    ${document}    Convert Html To Pdf    ${PAYLOAD_DIR}/${payload_file}    ${candidate_dir}
    [Return]    ${document}  
Get Document From WebService
    [Arguments]    ${payload_file}    ${candidate_dir}
    Log    Get Document From WebService
    ${document}    Convert Html To Pdf    ${PAYLOAD_DIR}/${payload_file}    ${candidate_dir}
    [Return]    ${document}  