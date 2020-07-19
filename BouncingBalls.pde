// Clicking on a ball destroys it
// Pressing SPACE pauses/resumes the program
// Pressing ENTER creates a new ball
// Pressing "s" changes the color of all balls
int numBalls, colorChange, ballToKill;
float spring, gravity, friction;
boolean looping, killBall;
ArrayList<Ball> balls;

void setup() {  
  size(1000, 800);

  // Variables
  numBalls = 20; // Number of initial balls
  spring = 1; // Bounciness of balls
  gravity = 0.03; // Gravity improvement
  friction = -0.4;
  colorChange = 1; // Modifier for changing color on keypress
  looping = true; // Pause program if false
  killBall = false;
  balls  = new ArrayList<Ball>();
  noStroke();

  // Create balls based on numBalls
  for (int i = 0; i < numBalls; i++) {
    balls.add(new Ball(random(width), random(height), random(30, 70), i, balls, color(random(0, 255), random(0, 255), random(0, 255)))); // Params: X, Y, Diameter, otherBalls, Color
  }
}

void draw() {
  if (looping) { // Should program run?
    background(0);
    for (int i = balls.size()-1; i >= 0; i--) { // Iterate through all balls backwards in order to prevent problems in "killing" a ball
      balls.get(i).collide(); // Check collision with other balls
      balls.get(i).move(); // Move this ball
      balls.get(i).display(); // Display this ball

      if (balls.get(i).id == ballToKill && killBall == true && frameCount % 2 == 0) { // Check if this ball should get killed on every 2nd frame. This is in order for the ball to get smaller and smaller until it disappears.
        balls.get(i).kill(ballToKill); // Call ballKill function
        try { // Try-Catch to prevent access-none errors since the instance could already be removed
          if (balls.get(i).ballKilled)
            killBall = false;
        }
        catch (Exception e) { // Reset killBall in any case
          killBall = false;
        }
      }
    }
  }
}

// Change color while key 's' is pressed
void keyPressed() { 
  if (key == 's' || key == 'S') {
    for (int i = 0; i < balls.size(); i++) { // Iterate through all balls
      if (red(balls.get(i).colorBall) < 255) {  // if red-value of this ball is under 255, increase it
        balls.get(i).colorBall += color(colorChange, 0, 0);
      } else if (green(balls.get(i).colorBall) < 255) { // else if green-value of this ball is under 255, increase it
        balls.get(i).colorBall += color(0, colorChange, 0);
      } else if (blue(balls.get(i).colorBall) < 255) { // else if blue-value of this ball is under 255, increase it
        balls.get(i).colorBall += color(0, 0, colorChange);
      } else {  // else set a random color for this ball
        balls.get(i).colorBall = color(random(0, 255), random(0, 255), random(0, 255));
      }
    }
  }
}

// If SPACE was pressed pause/resume animation, if ENTER was pressed, create a new ball
void keyReleased() {
  if (key == 32) {
    looping = !looping;
  } else if (key == CODED) { 
    if (keyCode == ENTER) {
      balls.add(new Ball(random(width), random(height), random(30, 70), balls.size(), balls, color(random(0, 255), random(0, 255), random(0, 255))));
    }
  }
}

// If mouse-left was released, check if program is active and check if the mouse hovers over a ball. If it's over a ball, set ball kill for this ball-id
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
