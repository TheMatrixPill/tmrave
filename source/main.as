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
    vec2 pos = vec2(i * stepSize, -10);
    if(i == 0 && cnt == 1)
      pos = vec2(stepSize / 2, -10);

    int dir = 0;
    if(RandomStartDirection)
      dir = Math::Rand(0,2);
    int start = 0;
    int end = 180;
    if(i == 0){
      if(!FirstAndLast180)
        end = 90;
    }
    else if(i == cnt - 1){
      if(!RandomStartDirection)
        dir = 1;
      if(!FirstAndLast180)
        start = 90;
    }
    else{
      if(!RandomStartDirection) {
        if(i % 2 == 0)
          dir = 0;
        else
          dir = 1;
      }
    }
    lights.InsertLast(Light(pos, start, end, dir));
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

