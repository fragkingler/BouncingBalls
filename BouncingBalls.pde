// Clicking on a ball destroys it
// Pressing SPACE pauses/resumes the program
// Pressing ENTER creates a new ball
// Pressing "s" changes the color of all balls
int numBalls = 20;
float spring = 1;
float gravity = 0.03;
float friction = -0.4;
ArrayList<Ball> balls = new ArrayList<Ball>();
int colorChange = 1;
boolean looping = true, killBall = false;
int ballToKill;

void setup() {  
  size(1000, 800);
  for (int i = 0; i < numBalls; i++) {
    balls.add(new Ball(random(width), random(height), random(30, 70), i, balls, color(random(0, 255), random(0, 255), random(0, 255))));
  }
  noStroke();
  fill(255, 204);
}

void draw() {
  if (looping) {
    background(0);
    for (int i = balls.size()-1; i >= 0; i--) {
      balls.get(i).collide();
      balls.get(i).move();
      balls.get(i).display();

      if (balls.get(i).id == ballToKill && killBall == true && frameCount % 2 == 0) {
        balls.get(i).kill(ballToKill);
        try {
          if (balls.get(i).ballKilled)
            killBall = false;
        }
        catch (Exception e) {
          killBall = false;
        }
      }
    }
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    for (int i = 0; i < balls.size(); i++) {
      if (red(balls.get(i).colorBall) < 255) { 
        balls.get(i).colorBall += color(colorChange, 0, 0);
      } else if (green(balls.get(i).colorBall) < 255) { 
        balls.get(i).colorBall += color(0, colorChange, 0);
      } else if (blue(balls.get(i).colorBall) < 255) { 
        balls.get(i).colorBall += color(0, 0, colorChange);
      } else { 
        balls.get(i).colorBall = color(random(0, 255), random(0, 255), random(0, 255));
      }
    }
  }
}

void keyReleased() {
  if (key == 32) {
    looping = !looping;
  } else if (keyCode == 10) {
    balls.add(new Ball(random(width), random(height), random(30, 70), balls.size(), balls, color(random(0, 255), random(0, 255), random(0, 255))));
  }
}

void mouseReleased() {
  if (looping) {
    for (int i = balls.size()-1; i >= 0; i--) {
      Ball ball = balls.get(i);
      if ((ball.x + ball.diameter/2) > mouseX && (ball.x - ball.diameter/2) < mouseX && (ball.y + ball.diameter/2) > mouseY && (ball.y - ball.diameter/2) < mouseY) {
        //ball.kill(i);
        ballToKill = ball.id;
        killBall = true;
      }
    }
  }
}
