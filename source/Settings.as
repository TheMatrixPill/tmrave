[Setting category="Lights" name="Count of lights" drag min=0 max=10]
uint LightCount = 2;

[Setting category="Lights" name="Make individual lightspeed random on direction change" description="The Speed setting below will be taken as a max speed" ]
bool RandomSpeed = false;

[Setting category="Lights" name="Speed of all lights" drag min=0.5 max=5]
float GlobalSpeed = 2;

[Setting category="Lights" name="Random start direction" ]
bool RandomStartDirection = false;

[Setting category="Lights" name="Light opacity" drag min=0.01 max=1]
float LightOpacity = 0.2f;

[Setting category="Lights" name="Light width" drag min=10 max=800]
uint LightWidth = 200;

[Setting category="Lights" name="First and Last also 180°" ]
bool FirstAndLast180 = false;
