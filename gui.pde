//VARIABLER
String input_string;
GTextField InputFelt; 
GCheckbox BOX_antal_c; 
GCheckbox BOX_gruppe; 
GCheckbox BOX_molekyleformel; 
GButton BUTTON_reset; 

//INPUTFELT
void Input_change(GTextField source, GEvent event) { 
  if (keyPressed) {
    if (event.equals(GEvent.ENTERED)) {  //hvis GUI's event svarer til der skrives noget, sætte vi vores egen boolean writing_confirmed,
      writing_confirmed = true;          //til true, og laver en string ud af inputtet.
      input_string = source.getText();
    }
  }
} 

//CHECKBOX 1
void BOX1_clicked(GCheckbox source, GEvent event) { 
  if (event.equals(GEvent.SELECTED)) {   //vi sætter blot boolean til true hvis der er klikket,
    Box1_selected = true;                //og bestemmer hvad der skal ske under 'ONG'.
  } else {
    Box1_selected = false;
  }
} 

//CHECKBOX 2
void BOX2_clicked(GCheckbox source, GEvent event) {
  if (event.equals(GEvent.SELECTED)) {  //samme som box 1
    Box2_selected = true;
  } else { 
    Box2_selected = false;
  }
} 

//CHECKBOX 3
void BOX3_clicked(GCheckbox source, GEvent event) { 
  if (event.equals(GEvent.SELECTED)) {  //samme som box 1
    Box3_selected = true;
  } else {
    Box3_selected = false;
  }
} 

//RESET KNAP
void button_clicked(GButton source, GEvent event) { 
  if (event.equals(GEvent.CLICKED)) {     //hvis RESET knappen trykkes på fjernes hakker fra alle checkboksene,
    BOX_antal_c.setSelected(false);      //og vi sætter vores booleans til false så der ikke vises tekst.
    Box1_selected = false;

    BOX_gruppe.setSelected(false);
    Box2_selected = false;

    BOX_molekyleformel.setSelected(false);
    Box3_selected = false;
  }
} 

// AUTOGENERERET GUI CONTROLS fra G4P
void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  InputFelt = new GTextField(this, 147, 102, 350, 70, G4P.SCROLLBARS_NONE);
  InputFelt.setPromptText("Skriv dit molekylenavn her");
  InputFelt.setOpaque(true);
  InputFelt.addEventHandler(this, "Input_change");
  BOX_antal_c = new GCheckbox(this, 667, 294, 85, 40);
  BOX_antal_c.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  BOX_antal_c.setText("Antallet af carbon atomer");
  BOX_antal_c.setTextBold();
  BOX_antal_c.setOpaque(false);
  BOX_antal_c.addEventHandler(this, "BOX1_clicked");
  BOX_gruppe = new GCheckbox(this, 667, 343, 87, 56);
  BOX_gruppe.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  BOX_gruppe.setText("Funktionel gruppe i molekylet");
  BOX_gruppe.setTextBold();
  BOX_gruppe.setOpaque(false);
  BOX_gruppe.addEventHandler(this, "BOX2_clicked");
  BOX_molekyleformel = new GCheckbox(this, 666, 409, 87, 36);
  BOX_molekyleformel.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  BOX_molekyleformel.setText("Molekyleformel");
  BOX_molekyleformel.setTextBold();
  BOX_molekyleformel.setOpaque(false);
  BOX_molekyleformel.addEventHandler(this, "BOX3_clicked");
  BUTTON_reset = new GButton(this, 675, 195, 65, 65);
  BUTTON_reset.setText("RESET");
  BUTTON_reset.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  BUTTON_reset.addEventHandler(this, "button_clicked");
}
