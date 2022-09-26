import random
import cv2
import os

def add_random_shapes_to_image(image, output):
    """
    Adds a random number of shapes to an image
    Shapes can have random colors and random sizes
    :param image: image to add shapes to
    :param output: output file
    :return: None
    """
    # Read the image
    img = cv2.imread(image)
    # Get the number of shapes to add
    num_shapes = random.randint(1, 10)
    # Add the shapes
    for i in range(num_shapes):
        # Get the shape type
        shape_type = random.randint(0, 2)
        # Get the shape color
        color = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))
        # Get the shape size
        size = random.randint(10, 100)
        # Get the shape location
        x = random.randint(0, img.shape[1])
        y = random.randint(0, img.shape[0])
        # Add the shape
        if shape_type == 0:
            cv2.circle(img, (x, y), size, color, -1)
        elif shape_type == 1:
            cv2.rectangle(img, (x, y), (x + size, y + size), color, -1)
        else:
            cv2.ellipse(img, (x, y), (size, size), 0, 0, 360, color, -1)
    # Save the image
    cv2.imwrite(output, img)
    # return the absolute path of output file
    return os.path.abspath(output)