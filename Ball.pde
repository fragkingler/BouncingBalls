class Ball {
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  color colorBall;
  int id;
  ArrayList<Ball> others;
  boolean ballKilled = false;

  // Constructor
  Ball(float xIn, float yIn, float diaIn, int idIn, ArrayList othersIn, color colorIn) {
    x = xIn;
    y = yIn;
    diameter = diaIn;
    id = idIn;
    others = othersIn;
    colorBall = colorIn;
  } 

  // Check if this ball collides with other balls
  void collide() {
    for (int i = others.size()-1; i >= 0; i--) {
      float dx = others.get(i).x - this.x;
      float dy = others.get(i).y - this.y;
      float distance = sqrt(dx*dx + dy*dy);
      
      // Calculate, if ball A collides with ball B and calculate a new direction
      float minDist = others.get(i).diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others.get(i).x) * spring;
        float ay = (targetY - others.get(i).y) * spring;
        vx -= ax;
        vy -= ay;
        others.get(i).vx += ax;
        others.get(i).vy += ay;
      }
    }
  }

  // Move the ball influenced by gravity. Also check the edges of the screen
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction;
    } else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction;
    } else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }

  // Draw the actual ball
  void display() {
    fill(colorBall, 200);
    ellipse(x, y, diameter, diameter);
  }

  // Kill the ball
  boolean kill(int ballToKill) {
    if (diameter > 0) { // Is the ball existent with a diameter > 0?
      diameter -= 10; // Decrease diameter
      if (diameter <= 8) {
        diameter = 0;
        ballKilled = true;
        for (int i = others.size()-1; i >= 0; i--) { // Remove this ball from the others-arraylist
          if (others.get(i).id == ballToKill)
            others.remove(i);
        }
      }
    }
    return ballKilled; // Return if the ball was successfully killed
  }
}
