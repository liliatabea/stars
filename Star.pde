class Star {
  float x;
  float y;
  float r;
  int numPoints;
  float randomRadius;
  float randomPointRadius;
  float randomInnerRadiusFactor;
  float rotationAngle; // Added rotation angle variable

  Star(float x_, float y_, float r_, int numPoints_, float rotationAngle_) {
    x = x_;
    y = y_;
    r = r_;
    numPoints = numPoints_;
    rotationAngle = rotationAngle_;
    
    // Random factors for overall star radius, individual point radius, and inner radius factor
    randomRadius = random(0.8, 1.2);
    randomPointRadius = random(0.8, 1.2);
    randomInnerRadiusFactor = random(0.4, 0.9); // Adjust the range as needed
  }

  void display() {
    fill(0);
    noStroke();
    beginShape();
    float angleOff = PI / 2; // Offset angle to make the star point upwards
    for (int i = 0; i < numPoints * 2; i++) {
      float angle = angleOff + TWO_PI / (numPoints * 2) * i;
      
      // Use separate random factors for outer and inner radius
      float outerRadius = r * randomPointRadius;
      float innerRadius = r / 2 * randomInnerRadiusFactor;

      float pointRadius = (i % 2 == 0) ? outerRadius : innerRadius;

      float rotatedX = x + cos(angle + rotationAngle) * pointRadius;
      float rotatedY = y + sin(angle + rotationAngle) * pointRadius;

      vertex(rotatedX, rotatedY);
    }
    endShape(CLOSE);
  }
}
