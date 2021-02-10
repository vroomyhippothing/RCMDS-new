ArrayList<Button> buttons;
ArrayList<Axis> axes;
ArrayList<UIButton> uibuttons;
ArrayList<UIIndicator> uiindicators;
ArrayList<UIJoystick> uijoysticks;
ArrayList<UISlider> uisliders;

String name;
String[] msg = new String[0];
int[] nums = new int[6];

void objectSetup(String file) {
  println("");
  println("File: "+imput+".txt");
  if (fileExists(dataPath(imput+".txt"))) {
    buttons=new ArrayList<Button>();
    axes=new ArrayList<Axis>();
    uibuttons=new ArrayList<UIButton>();
    uiindicators=new ArrayList<UIIndicator>();
    uijoysticks=new ArrayList<UIJoystick>();
    uisliders=new ArrayList<UISlider>();
    try {

      String[] config;
      String[] line;
      int a=0;

      config = loadStrings(file+".txt");

      name = config[a];
      a++;

      wifiIP = split(config[a],":")[0];
      wifiPort = int(split(config[a],":")[1]);
      enabled=false;
      a++;

      msg=split(config[a], ";");
      a++;

      numCtrl = int(split(config[a], ',')[0]);
      numRecv = int(split(config[a], ',')[1]);
      arrayToSend=new byte[4*numCtrl+8];
      arrayRecvd=new int [4*numRecv+8];
      a+=2;
      
      data = new float [numCtrl+numRecv];
      
      nums = new int[6];

      for (; !config[a].equals(""); a++) {
        line = split(config[a], ',');
        buttons.add(new Button(line));
        nums[0]++;
      }
      a++;
      for (; !config[a].equals(""); a++) {
        line = split(config[a], ',');
        axes.add(new Axis(line));
        nums[1]++;
      }
      a++;
      for (; !config[a].equals(""); a++) {
        line = split(config[a], ',');
        uibuttons.add(new UIButton(line));
        nums[2]++;
      }
      a++;
      for (; !config[a].equals(""); a++) {
        line = split(config[a], ',');
        uiindicators.add(new UIIndicator(line));
        nums[3]++;
      }
      a++;
      for (; !config[a].equals(""); a++) {
        line = split(config[a], ',');
        uijoysticks.add(new UIJoystick(line));//
        nums[4]++;
      }
      a++;
      for (; a<config.length && !config[a].equals(""); a++) {
        line = split(config[a], ',');
        uisliders.add(new UISlider(line));//
        nums[5]++;
      }
      println("File Successful");
      oldFile=imput;
      error = null;
    }
    catch (Throwable e) {
      if ( oldFile != null) {
        objectSetup(oldFile);
      }
      error = "Bad config file";
      e.printStackTrace();
    }
  } else {
    error = "File not found";
    println("File not found");
  }
}
  
void runObjects () {
  for (int i=0; i<nums[2]; i++) {
    uibuttons.get(i).runVar();
  }
  for (int i=0; i<nums[1]; i++) {
    axes.get(i).run();
  }
  for (int i=0; i<nums[0]; i++) {
    buttons.get(i).run();
  }
  for (int i=0; i<nums[3]; i++) {
    uiindicators.get(i).runVar();
  }
  for (int i=0; i<nums[4]; i++) {
    uijoysticks.get(i).runVar();
  }
  for (int i=0; i<nums[5]; i++) {
    uisliders.get(i).runVar();
  }
  for (int i=0; i<nums[2]; i++) {
    uibuttons.get(i).runUI();
  }
  for (int i=0; i<nums[3]; i++) {
    uiindicators.get(i).runUI();
  }
  for (int i=0; i<nums[4]; i++) {
    uijoysticks.get(i).runUI();
  }
  for (int i=0; i<nums[5]; i++) {
    uisliders.get(i).runUI();
  }
}

boolean fileExists(String path) {
  File file=new File(path);
  boolean exists = file.exists();
  if (exists) {
    return true;
  } else {
    return false;
  }
}
