//v1.4.1

HashSet<Integer> virtualKeyboardButton;
HashSet<String> virtualGamepadButton;
String[] Window;
String imput = "robbie";
String oldFile;
String error = null;
String setup = "";
boolean enabled = false;
boolean ctrlPressed = false;
boolean auto = false;
int numCtrl;
int numRecv;
float[] data;
float scaleFactor;
PrintWriter output;
int autoKey;

void setup() {
  surface.setSize(576, 324);
  virtualKeyboardButton=new HashSet<Integer>();
  virtualGamepadButton=new HashSet<String>();
  output = createWriter("log.txt"); 
  windowSetup("setup");
  if (setup.equals("")) {
    udp = new UDP(this);
    udp.listen(true);
    objectSetup(imput, true);
  }
}

void draw() {
  if (setup.equals("")) {
    background(10);
    fill(20);
    noStroke();
    rect(width/2, height*rectHeight/2, width, height*rectHeight);
    if (!auto) {
      virtualKeyboardButton.add(autoKey);
      auto = true;
    }
    enabled=runEnableSwitch(enabled);
    runObjects();
    runTypeBox();
    batVolts.run(nf(data[numCtrl], 0, 2)+" V");
    batGraph.run(data[numCtrl]);
    sendWifiData(true);
    robotName.run("Name: "+name);
    dispTelem.run(msg);
    if (keyboardCtrl.justPressed(12)) {
      launch(dataPath("log.txt"));
    }
    if (keyboardCtrl.justPressed(15)) {
      launch(dataPath(oldFile+".txt"));
    }
    if (keyboardCtrl.justPressed(16)) {
      launch(dataPath("setup.txt"));
    }
    if (keyboardCtrl.justPressed(18)) {
      windowSetup("setup");
      objectSetup(oldFile, true);
    }
    keyboardCtrl.oldKeys=(HashSet)keyboardCtrl.keys.clone();
    virtualKeyboardButton.clear();
    virtualGamepadButton.clear();
  } else {
    surface.setSize(300, 50);
    textSize(30);
    background(10);
    textAlign(CENTER, CENTER);
    fill(200, 0, 0);
    text(setup, width/2, height/2);
  }
}
