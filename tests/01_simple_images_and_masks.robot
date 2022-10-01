*** Settings ***
Library    DocTest.VisualTest    show_diff=true    take_screenshots=true    screenshot_format=png
Library    Collections

*** Test Cases ***
Compare two different Beach images
    Compare Images    testdata/image/Beach_left.jpg    testdata/image/Beach_right.jpg

Compare two different Farm images
    Compare Images    testdata/image/Farm_left.jpg    testdata/image/Farm_right.jpg

Compare two Beach images with a date and number
    Compare Images    testdata/image/Beach_date.png    testdata/image/Beach_left.png

Compare two Farm images with area mask as string
    Compare Images    testdata/image/Beach_date.png    testdata/image/Beach_left.png    mask=top:10;bottom:10

Compare two Beach images with date and pattern mask as file
    Compare Images    testdata/image/Beach_date.png    testdata/image/Beach_left.png    placeholder_file=testdata/masks/pattern_mask.json

Compare two Farm images with pattern mask as Dictionary
    ${letter_mask}    Create Dictionary    type=pattern    pattern=SOUVENIR
    ${text}    Get Text From Document    testdata/image/Beach_date.png
    Compare Images    testdata/image/Beach_date.png    testdata/image/Beach_left.png    mask=${letter_mask}

Compare two Farm images with area mask as list
    ${top_mask}    Create Dictionary    page=1    type=area    location=top    percent=10
    ${bottom_mask}    Create Dictionary    page=all    type=area    location=bottom    percent=10
    ${masks}    Create List    ${top_mask}    ${bottom_mask}
    Compare Images    testdata/image/Beach_date.png    testdata/image/Beach_left.png    mask=${masks}

