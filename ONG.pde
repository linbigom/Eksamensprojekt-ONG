//IMPORTS
import g4p_controls.*;

//VARIABLER
PImage background_img;

int tray_x = 100, tray_y = 200;
int tray_width = 433, tray_height = 290;
int w = 35;

boolean writing_confirmed = false; 
boolean Box1_selected = false; 
boolean Box2_selected = false; 
boolean Box3_selected = false; 

//OBJEKTER
Molecule Product;  //opretter objektet product som er et Molekyle

//SETUP FUNKTION
void setup() {
  size(850, 550);
  background_img = loadImage("background.jpg");   //baggrundbilledet background_img loades kun en enkelt gang fra mappen 'data'
  background_img.resize(850, 550);                //bagrundsbilledet formateres således den passe til skærmstørrelsen - helt ned til pixel-niveau
  createGUI();                                    //metoden fra gui laves, så bliver alle boks- og knap-objekterne initialiseret.
}

//DRAW FUNKTION - kører 60 frames per sekund per. default. Altså tegnes denne 60 gange i minuttet.
void draw() {
  interface_background(background_img);                     //baggrunden tegnes gennem funktionen Background, så den ikke fylder i den 'vigtige' kode
  //baggrunden tegnes før alt andet så den altid ligger 'nederst'
  if (writing_confirmed) {   //sørger for at det kun at hvis nogen skriver har trykket enter, at man tager inputtet og bruger det til noget

    char[] input_array = input_string.toCharArray();        //tager inputtet og laver det til et char array, således kan vi benytte specifikke bogstaver fra input

    int chainlength = chainlength_function(input_array);    //disse tre funktioner giver værdier til de tre variabler, funktionerne ligger under INPUT TREATMENT, så de ikke forstyrrer
    int f_group = f_group_function(input_array);
    int position = position(input_array, f_group);

    if (catch_errors(chainlength, position, f_group)) {  //sørger for at der ikke er fejl i inputtet med funktionen catch_errors som evaluerer true eller false, ligger under ERROR CATCHING
      Product = new Molecule(chainlength, position, f_group);        //hvis ikke der er fejl, laves et nyt Molekyle objekt 'product'
      pushMatrix();
      translate(tray_x + 50, tray_y + tray_y / 2 );                //molekylet tegnes med defineret nyt koordinatsystem og gøres sort.
      fill(0);
      Product.draw();
      popMatrix();
    }

    //INTERFACE FUNKTIONER - alle disse benytter sig af funktioner som findes under TRANSLATORS
    if (Box1_selected) {
      text("Der er " + chainlength + " carbon atome(r) i dette molekyle.", 150, 400);
    }
    if (Box2_selected) {
      if (f_group == 3) { //hvis det er en alkan er der selvfølgelig ikke nogen funktionel gruppe.
        text("Der er ingen funktionelle grupper i dette molekyle.", 150, 420);
      } else {
        text("Den funktionelle gruppe i dette molekyler er en " + name_of_f_group(f_group) + ".", 150, 420);
      }
    }
    if (Box3_selected) {
      int[] bonds_and_oxygens = calculate_bonds_oxygen(f_group);

      int n_H = 2 * chainlength + 2 - 2 * bonds_and_oxygens[0];     //antallet af H'er, O'er, og C'er i molekylet laves til variabler.
      int n_O = bonds_and_oxygens[1];
      int n_C = chainlength;

      if (n_O == 0) {                                               //siger to foeskellige ting, afhængig om det er med oxygen eller uden.
        text("Molekyleformlen er C" + n_C + "H" + n_H, 150, 440);
      } else {
        text("Molekyleformlen er C" + n_C + "H" + n_H + "O" + n_O, 150, 440);
      }
    }
    fill(255); //standard fill returneres til hvis så baggrunden ikke bliver hvid næste gang.
  }
}

//ANDRE FUNKTIONER
//-------------------------------------------------------BACKGROUND-------------------------------------------------------//

void interface_background(PImage picture) {
  background(picture);
  rect(tray_x, tray_y, tray_width, tray_height);       //tegneflade
  fill(255);
  rect(630, 150, 160, 350, 100);                       //instrumentbræt
  fill(0);
  textSize(35);
  text("ONG - Organisk Nomenklatur Generator", tray_x, 70);
  textSize(12);
  fill(255);
}

//-------------------------------------------------------INPUT TREATMENT-------------------------------------------------------//

int chainlength_function(char[] in) {
  String three_first_chars = "" + in[0] + in[1] + in[2];   //"",ellers prøver programmet at plusse
  int chainlength = 0;
  switch(three_first_chars) {        //Switch der sætter variablen chainlenght til en værdi afhængig af de tre først bogsatver i input
  case "met":
    chainlength = 1;
    break;
  case "eth":
    chainlength = 2;
    break;
  case "pro":
    chainlength = 3;
    break;
  case "but":
    chainlength = 4;
    break;
  case "pen":
    chainlength = 5;
    break;
  case "hex":
    chainlength = 6;
    break;
  case "hep":
    chainlength = 7;
    break;
  case "oct":
    chainlength = 8;
    break;
  case "non":
    chainlength = 9;
    break;
  case "dec":
    chainlength = 10;
    break;
  }
  return chainlength;      //returnerer længden af carbonkæden
} 

int position(char[] in, int f_group) {     //funktion der returnerer int værdien af f_groups position. 
  if (f_group == 3) {                      //Gør den ved at tage den den tredje sidste char og laver den om til en int, (skal være et tal for den virker).
    return 0;
  } else {
    int position = Integer.parseInt(String.valueOf(in[in.length-3]));
    return position;
  }
}

int f_group_function(char[] in) {
  String two_last_chars = "" + in[in.length-2] + in[in.length-1];
  int f_group = 0;
  switch(two_last_chars) {             //bruger det tal-assignment der er lavet for funktionelle grupper i rapporten.
  case "ol":                           //Afgøre dette tal på baggrund af de to sidste bogstaver i inputtet.
    f_group = 1;
    break;
  case "al":
    f_group = 2;
    break;
  case "an":
    f_group = 3;
    break;
  case "en":
    f_group = 4;
    break;
  case "yn":
    f_group = 5;
    break;
  case "on":
    f_group = 6;
    break;
  }
  return f_group;
}

//-------------------------------------------------------ERROR CATCHING-------------------------------------------------------//

boolean catch_errors(int chainlength, int position, int f_group) {    //boolean funktion der returnerer false hvis den fanger fejl og skriver hvad der er galt.
  fill(0);
  boolean proceed = false;
  if (chainlength < position) {  
    text("Tjek om din position af den funktionelle gruppe korosponderer" + "\n" + "med din kædelængde, og om du har stavet navnet rigtigt...", tray_x + 15, tray_y + 100);
  } else if (f_group == 6 &&  position == 1) {  //hvis det er en keton i starten
    text("En keton kan ikke sidde for enden af en carbonkæde...", tray_x + 15, tray_y + 100);
  } else if (f_group == 6 &&  position == chainlength) {  //hvis det er en keton i slutningen af kæden
    text("En keton kan ikke sidde for enden af en carbonkæde...", tray_x + 15, tray_y + 100);
  } else if ((f_group == 2) && (chainlength > position) && (position > 1)) {  //hvis det er en aldehyd der ikke sidder i en af enderne
    text("En aldehyd kan kun sidde for enden af en carbonkæde...", tray_x + 15, tray_y + 100);
  } else {
    proceed = true;
  }
  fill(255);
  return proceed;
}



//-------------------------------------------------------TRANSLATORS-------------------------------------------------------//

String name_of_f_group(int f_group) {  //oversætter den funktionelle gruppe's nummer til et helt navn.
  String name = "";
  switch(f_group) {
  case 1:
    name = "alkohol";
    break;
  case 2:
    name = "aldehyd";
    break;
  case 4:
    name = "alken";
    break;
  case 5:
    name = "alkyn";
    break;
  case 6:
    name = "keton";
    break;
  }
  return name;
}

int[] calculate_bonds_oxygen(int f_group) {    //laver array der fortæller [0] hvor mange dobbeltbindinger der er,
  int[] bonds_and_oxygens = new int[2];        //og [1] hvor mange oxygener der er, i den funktionelle gruppe
  switch(f_group) {
  case 1:
    bonds_and_oxygens[0] = 0;
    bonds_and_oxygens[1] = 1;
    break;
  case 3:
    bonds_and_oxygens[0] = 0;
    bonds_and_oxygens[1] = 0;
    break;
  case 4:
    bonds_and_oxygens[0] = 1;
    bonds_and_oxygens[1] = 0;
    break;
  case 5:
    bonds_and_oxygens[0] = 2;
    bonds_and_oxygens[1] = 0;
    break;
  case 2:              //case 2 og 6 er den samme, derfor intet break
  case 6:
    bonds_and_oxygens[0] = 1;
    bonds_and_oxygens[1] = 1;
    break;
  }
  return bonds_and_oxygens;
}

//------------------------------------------------------------------------------------------------------------------------------------------------//
