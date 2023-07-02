class Light {
  vec4 color;
  vec2 origin;
  int minDegrees;
  int maxDegrees;
  int direction = 0;
  float stepSize = 1;
  int currentStep = 0;
  int speed = 2;

  Light(const vec2&in orig, int minDeg, int maxDeg, int direction = 0){
    generateColor();
    origin = orig;
    minDegrees = minDeg;
    maxDegrees = maxDeg;
    this.direction = direction;
    if(direction == 1){
      currentStep = 360;
    }
    stepSize = (maxDeg - minDeg) / 360.0;

  }

  void Draw(){
    float angle = Math::ToRad(stepSize * currentStep + minDegrees);

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
      currentStep += speed;
    }
    else{
      currentStep -= speed;
    }
    if(currentStep > 360){
      direction = 1;
      generateColor();
      currentStep = 360;
    }
    if(currentStep < 0) {
      direction = 0;
      generateColor();
      currentStep = 0;
    }
  }

  vec2 GetUpperVec(){
    return vec2(GetDiag(), -200);
  }

  vec2 GetLowerVec(){
    return vec2(GetDiag(), 200);
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