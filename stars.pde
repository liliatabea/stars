import processing.pdf.*;

Star[] stars = new Star[1000];
float minDistance = 20; // Minimum distance between stars
float randomSize = 1;
void setup() {
  size(700, 1000);
  smooth();

  float centerX = width / 2;  // Calculate the center X-coordinate
  float centerY = height / 2; // Calculate the center Y-coordinate

  // Initialize the array of stars with radial distribution
  for (int i = 0; i < stars.length; i++) {
    float radius;
    if (i % 5 == 0) {
      // If it's the 5th star, re-calculate with the specified radius
      radius = pow(random(1), 2) * height /  2;
    } else {
      // If it's the 5th star, re-calculate with the specified radius
      radius = pow(random(1), 0.5) * min(width*1.2, height) / .6;
    }
          randomSize = random(2, 14);

    float angle = random(TWO_PI);
    float rotationAngle = radians(random(-10, 10)); // Random rotation angle

    float randomX = centerX + radius * cos(angle);
    float randomY = centerY + radius * sin(angle);

    // Check for overlapping and reposition if necessary
    while (isOverlapping(randomX, randomY, stars, i)) {
      if (i % 2 == 0) {
        radius = pow(random(1), 2) * min(width, height) / 3; // Recalculate radius
      } else {
        radius = pow(random(1), 2) * min(width, height) / 4; // Recalculate radius
      }
      angle = random(TWO_PI);
      randomX = centerX + radius * cos(angle);
      randomY = centerY + radius * sin(angle);
      randomSize = random(6, 25);
    }

    int randomPoints = int(random(5, 9));
    stars[i] = new Star(randomX, randomY, randomSize, randomPoints, rotationAngle);
  }

  // Generate pdf
  noLoop();
  // Save file as pdf
  beginRecord(PDF, "stars.pdf");
}

void draw() {
  background(255);

  // Display all stars in the array
  for (int i = 0; i < stars.length; i++) {
    stars[i].display();
  }

  endRecord();
}

// Function to check if a new star overlaps with existing stars
boolean isOverlapping(float x, float y, Star[] existingStars, int currentIndex) {
  for (int i = 0; i < currentIndex; i++) {
    float distance = dist(x, y, existingStars[i].x, existingStars[i].y);
    if (distance < minDistance) {
      return true; // Overlapping
    }
  }
  return false; // Not overlapping
}
