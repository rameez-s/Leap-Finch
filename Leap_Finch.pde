import com.onformative.leap.*;
import com.leapmotion.leap.*;

import edu.cmu.ri.createlab.terk.robot.finch.*;

LeapMotionP5 leap;
Finch jo = new Finch();

void setup() {
  size(600, 600, P3D);
  noFill();
  stroke(255);
  leap = new LeapMotionP5 (this);
}

void draw() {
  background (0);

  for (Hand hand : leap.getHandList ()) {
    pushMatrix();
    PVector handPosition = leap.getPosition(hand);
    translate(handPosition.x, handPosition.y);
    float pitch = leap.getPitch(hand);
    float yaw = leap.getYaw(hand);
    float roll = leap.getRoll(hand);

    rotateX(radians(map(pitch, -30, 30, 45, -45)));
    rotateY(radians(map(yaw, -12, 18, 45, -45)));
    rotateZ(radians(map(roll, -40, 40, 45, -45)));


    float handSize = leap.getSphereRadius(hand);
    sphere(handSize);
    popMatrix();

    if (pitch > -10 && pitch < 10 && roll < 10 && roll > -10) {
      jo.setWheelVelocities(0, 0);
    }

    //pitch
    if (pitch > 10) {
      jo.setWheelVelocities(-255, -255);
    }
    if (pitch < -10) {
      jo.setWheelVelocities(255, 255);
    }


    //roll
    if (roll > 30) {
      jo.setWheelVelocities(-255, 255);
    }
    if (roll < -30) {
      jo.setWheelVelocities(255, -255);
    }
  }
}
/* Code to be fixed: This is the rough sketch up for variable speed
int finchp() {
  for (Hand hand : leap.getHandList ()) {
    float pitch = leap.getPitch(hand);
    double p = round(pitch);
    return int((p/90)*255);
  }
}
int finchr() {
  for (Hand hand : leap.getHandList ()) {
    float roll = leap.getRoll(hand);
    double r = round(roll);
    return int((r/90)*255);
  }
}
*/
