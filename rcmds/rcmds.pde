//v1.1

HashSet<Integer> virtualKeyboardButton;
HashSet<String> virtualGamepadButton;
String[] Window;
String imput = "example";
String oldFile;
String error = null;
float[] data = new float[16];
boolean enabled = false;
String setup = "";

void setup() {
  virtualKeyboardButton=new HashSet<Integer>();
  virtualGamepadButton=new HashSet<String>();

  if (fileExists(dataPath("setup.txt"))) {
    try {
      windowSetup("setup");
    }
    catch (Throwable e) {
      setup = "bad setup file";
    }
  } else {
    setup = "missing setup file";
  }

  if (setup.equals("")) {
    udp = new UDP(this);
    udp.listen(true);

    if (fileExists(dataPath(imput+".txt"))) {
      try {
        objectSetup(imput);
        oldFile=imput;
      }
      catch (Throwable e) {
        error = "Bad config file";
        name = "error";
      }
    } else {
      error = "File does not exist";
      name = "error";
    }
  }
}

void draw() {
  if (setup.equals("")) {
    background(10);
    fill(20);
    noStroke();
    rect(width/2, height*rectHeight/2, width, height*rectHeight);
    enabled=runEnableSwitch(enabled);
    runObjects();
    runTypeBox();
    batVolts.run(nf(data[8], 0, 2)+" V");
    batGraph.run(data[8]);
    sendWifiData(true);
    robotName.run("Name: "+name);
    dispTelem.run(msg);
    
    if (keyboardCtrl.isPressed(15)) {
      launch(dataPath(oldFile+".txt"));
    }
    
    if (keyboardCtrl.isPressed(16)) {
      launch(dataPath("setup.txt"));
    }

    if (keyboardCtrl.isPressed(18)) {
      if (fileExists(dataPath("setup.txt"))) {
        try {
          windowSetup("setup");
        }
        catch (Throwable e) {
          setup = "bad setup file";
        }
      } else {
        setup = "missing setup file";
      }
      if (fileExists(dataPath(oldFile+".txt"))) {
        try {
          objectSetup(oldFile);
        }
        catch (Throwable e) {
          error = "Bad config file";
          name = "error";
        }
      } else {
        error = "File does not exist";
        name = "error";
      }
    }

    if (!focused) {
      enabled = false;
    }
  } else {
    surface.setSize(300, 50);
    textSize(30);
    background(10);
    textAlign(CENTER, CENTER);
    fill(200, 0, 0);
    text(setup, width/2, height/2);
  }
}
