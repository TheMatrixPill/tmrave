class Light {
  vec4 color;
  vec2 origin;
  int minDegrees;
  int maxDegrees;
  int direction = 0;
  float stepSize = 1;
  float currentAngle = 0;
  float speed = 2;

  Light(const vec2&in orig, int minDeg, int maxDeg, int direction = 0){
    generateColor();
    origin = orig;
    minDegrees = minDeg;
    maxDegrees = maxDeg;
    this.direction = direction;
    if(direction == 1){
      currentAngle = maxDeg;
    }
  }

  void Draw(){
    float angle = Math::ToRad(currentAngle);

    nvg::BeginPath();
    nvg::ResetTransform();
    nvg::Translate(origin);
    nvg::Rotate(angle);

    nvg::MoveTo(vec2(0,0));
    nvg::LineTo(GetUpperVec());
    nvg::LineTo(GetLowerVec());
    nvg::LineTo(vec2(0,0));

    nvg::FillColor(color);
    nvg::Fill();

    nvg::ClosePath();
  }

  void Move() {
    if(direction == 0){
      currentAngle += speed;
    }
    else{
      currentAngle -= speed;
    }
    if(currentAngle > maxDegrees){
      direction = 1;
      generateColor();
      currentAngle = maxDegrees;
    }
    if(currentAngle < minDegrees) {
      direction = 0;
      generateColor();
      currentAngle = minDegrees;
    }
  }

  vec2 GetUpperVec(){
    return vec2(GetDiag(), -LightWidth);
  }

  vec2 GetLowerVec(){
    return vec2(GetDiag(), LightWidth);
  }

  void generateColor() {
    float min = 0;
    float max = 1;
    float r = Math::Rand(min, max);
    float g = Math::Rand(min, max);
    float b = Math::Rand(min, max);
    float a = LightOpacity;
    color = vec4(r,g,b,a);

    if(RandomSpeed){
      speed = Math::Rand(1,GlobalSpeed);
    }
    else {
      speed = GlobalSpeed;
    }
  }

  float GetDiag(){
    int width = Draw::GetWidth();
    int height = Draw::GetHeight();
    return Math::Sqrt(Math::Pow(width,2) + Math::Pow(height,2));
  }
}