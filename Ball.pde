class Ball {
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  color colorBall;
  int id;
  ArrayList<Ball> others;
  boolean ballKilled = false;

  Ball(float xIn, float yIn, float diaIn, int idIn, ArrayList othersIn, color colorIn) {
    x = xIn;
    y = yIn;
    diameter = diaIn;
    id = idIn;
    others = othersIn;
    colorBall = colorIn;
  } 

  void collide() {
    for (int i = others.size()-1; i >= 0; i--) {
      float dx = others.get(i).x - x;
      float dy = others.get(i).y - y;
      float distance = sqrt(dx*dx + dy*dy);
      // calculate, if ball A collides with ball B
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

  void display() {
    fill(colorBall, 200);
    ellipse(x, y, diameter, diameter);
  }

  boolean kill(int ballToKill) {
    if (diameter > 0) {
      diameter -= 10;
      if (diameter <= 8) {
        diameter = 0;
        ballKilled = true;
        for (int i = others.size()-1; i >= 0; i--) {
          if (others.get(i).id == ballToKill)
            others.remove(i);
        }
      }
    }
    return ballKilled;
  }
}
