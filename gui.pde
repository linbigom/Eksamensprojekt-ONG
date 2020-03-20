/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. 
 
 * =========================================================
 */
 
//VARIABLER
String input_string;
GTextField InputFelt; 
GCheckbox BOX_struktur; 
GCheckbox BOX_gruppe; 
GCheckbox BOX_c; 
GButton BUTTON_reset; 

public void Input_change(GTextField source, GEvent event) { //_CODE_:InputFelt:273854:
  if (keyPressed) {
    if (event.equals(GEvent.ENTERED)) {
      writing_confirmed = true;
      input_string = source.getText();
    }
  }
} //_CODE_:InputFelt:273854:

public void BOX1_clicked(GCheckbox source, GEvent event) { //_CODE_:BOX_struktur:770322:
  if (event.equals(GEvent.SELECTED)) {
    Box1_selected = true;
  } else {
    Box1_selected = false;
  }
} //_CODE_:BOX_struktur:770322:

public void BOX2_clicked(GCheckbox source, GEvent event) { //_CODE_:BOX_gruppe:968604:
  if (event.equals(GEvent.SELECTED)) {
    Box2_selected = true;
  } else { 
    Box2_selected = false;
  }
} //_CODE_:BOX_gruppe:968604:

public void BOX3_clicked(GCheckbox source, GEvent event) { //_CODE_:BOX_c:756460:
  if (event.equals(GEvent.SELECTED)) {
    Box3_selected = true;
  } else {
    Box3_selected = false;
  }
} //_CODE_:BOX_c:756460:

public void button_clicked(GButton source, GEvent event) { //_CODE_:BUTTON_reset:929443:
  if (event.equals(GEvent.CLICKED)) {
    BOX_struktur.setSelected(false);
    Box1_selected = false;

    BOX_gruppe.setSelected(false);
    Box2_selected = false;

    BOX_c.setSelected(false);
    Box3_selected = false;
  }
} //_CODE_:BUTTON_reset:929443:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  InputFelt = new GTextField(this, 147, 102, 350, 70, G4P.SCROLLBARS_NONE);
  InputFelt.setPromptText("Skriv dit molekylenavn her");
  InputFelt.setOpaque(true);
  InputFelt.addEventHandler(this, "Input_change");
  BOX_struktur = new GCheckbox(this, 667, 294, 85, 40);
  BOX_struktur.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  BOX_struktur.setText("Antallet af carbon atomer");
  BOX_struktur.setTextBold();
  BOX_struktur.setOpaque(false);
  BOX_struktur.addEventHandler(this, "BOX1_clicked");
  BOX_gruppe = new GCheckbox(this, 667, 343, 87, 56);
  BOX_gruppe.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  BOX_gruppe.setText("Funktionel gruppe i molekylet");
  BOX_gruppe.setTextBold();
  BOX_gruppe.setOpaque(false);
  BOX_gruppe.addEventHandler(this, "BOX2_clicked");
  BOX_c = new GCheckbox(this, 666, 409, 87, 36);
  BOX_c.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  BOX_c.setText("Molekyleformel");
  BOX_c.setTextBold();
  BOX_c.setOpaque(false);
  BOX_c.addEventHandler(this, "BOX3_clicked");
  BUTTON_reset = new GButton(this, 675, 195, 65, 65);
  BUTTON_reset.setText("RESET");
  BUTTON_reset.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  BUTTON_reset.addEventHandler(this, "button_clicked");
}
