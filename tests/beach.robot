*** Settings ***
Library    DocTest.VisualTest    show_diff=true    take_screenshots=true    screenshot_format=png    #pdf_rendering_engine=ghostscript
Library    Collections

*** Test Cases ***
Compare two Beach images
    Run Keyword And Expect Error    The compared images are different.    Compare Images    testdata/image/Beach_left.jpg    testdata/image/Beach_right.jpg

Compare two Farm images
    Run Keyword And Expect Error    The compared images are different.    Compare Images    testdata/image/Farm_left.jpg    testdata/image/Farm_right.jpg

Compare two Farm images with date pattern
    Compare Images    testdata/image/Beach_date.png    testdata/image/Beach_left.png    placeholder_file=testdata/masks/pattern_mask.json

Compare two Farm images with area mask as list
    ${top_mask}    Create Dictionary    page=1    type=area    location=top    percent=10
    ${bottom_mask}    Create Dictionary    page=all    type=area    location=bottom    percent=10
    ${masks}    Create List    ${top_mask}    ${bottom_mask}
    Compare Images    testdata/image/Beach_date.png    testdata/image/Beach_left.png    mask=${masks}

Compare two Farm images with area mask as string
    Compare Images    testdata/image/Beach_date.png    testdata/image/Beach_left.png    mask=top:10;bottom:10