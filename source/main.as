array<Light@> lights;
float g_dt = 0;

void Main(){
  print("RaveTime");
  GenerateLights();
}

void GenerateLights(){
  if(lights.Length > 0){
    lights.RemoveRange(0,lights.Length);
  }
  uint cnt = LightCount;
  float stepSize = Draw::GetWidth();
  if(cnt > 1)
    stepSize = stepSize / (cnt - 1);
  for(uint i = 0; i < cnt; i++){
    if(i == 0){
      int dir = 0;
      if(RandomStartDirection)
        dir = Math::Rand(0,2);
      lights.InsertLast(Light(vec2(i * stepSize, -10), 0, 90, dir));
    }
    else if(i == cnt - 1){
      int dir = 1;
      if(RandomStartDirection)
        dir = Math::Rand(0,2);
      lights.InsertLast(Light(vec2(i * stepSize, -10), 90, 180, dir));
    }
    else{
      int dir = 0;
      if(RandomStartDirection)
        dir = Math::Rand(0,2);
      else {
        if(i % 2 == 0)
          dir = 0;
        else
          dir = 1;
      }

      lights.InsertLast(Light(vec2(i * stepSize, -10), 0, 180, dir));
    }
  }
}

void OnSettingsChanged(){
  GenerateLights();
}

void Render(){
  if(lights !is null){
    bool move = false;
    if (g_dt >= 10 ) {
      move = true;
      g_dt = 0;
    }
    for (uint i = 0; i < lights.Length; i++) {
      lights[i].Draw();
      if (move == true) {
        lights[i].Move();
      }
    }
  }
}

void Update(float dt) {
    g_dt += dt;
}

