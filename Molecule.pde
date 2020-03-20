class Molecule {
  //VARIABLER
  int n;
  int position;
  int f_group;

  //CONSTRUCTER
  Molecule(int chainlength, int position, int f_group) {
    n = chainlength;           //kædelængden kaldes n da det er ANTALLET af gange man skal lave zig zag.
    this.position = position;
    this.f_group = f_group;
  }
  
  //DRAW METODE
  void draw() {
    //LOKALE VARIBALER
    int x_of_current_C = 0;
    int y_of_current_C = 0;
    int new_x_coordinate;
    int new_Ycoordinate;

    int w = 35;
    int h = 30;
    
    //hvis det er methan u. f_group, tegnes der fisher-projektion
    if ((f_group == 3) && (n == 1)) {
      text("C", 50, 0);
      text("H", 20, 0);       //horisontale H'er.
      text("H", 80, 0);
      text("H", 50, -30);     //verticale H'er.
      text("H", 50, 30);
      line(48, -5, 29, -5);   //horisontale linjer.
      line(59, -5, 76, -5);
      line(54, -12, 54, -25); //verticale linjer.
      line(54, 2, 54, 20);
    } else {

    //FORLOOP - ellers tegnes carbonkæden i et forloop
    for (int i = 0; i <= n-1; i = i+1) {                            //loopet tegner linjer henholdsvis op og ned, og op og ned..., 
      new_x_coordinate = x_of_current_C + w;                        //men en linje beståer af to C'er, så ikke den sidste gang. Derfor sætte i=0 og stop ved n-1.
      new_Ycoordinate = y_of_current_C + (h / 2) - ((i % 2) * h);   //det nye x og y for det nye carbon beregnes.

      if (n-1 != i) {                                               //hvis vi ikke er i slutningen tegnes en linje mellem de to carbons.
        line(x_of_current_C, y_of_current_C, new_x_coordinate, new_Ycoordinate);
      }
      
      //IF-STATEMENT TIL FUNKTIONELLE GRUPPER - hvis tælleren er på positionen skal gruppen jo tegnes.
      if (i+1 == position) {
        
        //Alle lige i værdier for t, dvs. position 1,3,5,7,9 skal tegnes 'opad'.
        if ((i % 2) == 0) {
          pushMatrix();
            translate(x_of_current_C, y_of_current_C); 
            scale(1, -1); //spejlvender i x-aksen
            if ((f_group == 2) && (i == n-1)) {
              scale(-1, 1); //hvis det er en aldehyd i enden skal denne også spejlvendes i y-aksen.
            }
            draw_f_group(0, 0, f_group, w, h); //så kan molekylet tegnes vha. funktionen draw_f_group.
          popMatrix();
        } else {
          //Alle ulige i værdier for t, dvs. position 2,4,6,8 skal tegnes 'nedad', (by deafult tegnes de nedad, så der skal ikke ændres på noget).
          pushMatrix();
            translate(x_of_current_C, y_of_current_C);
            if ((f_group == 2) && (i == n-1)) {
              scale(-1, 1);  //aldehyden skal stadig vendes hvis den sidder i enden.
            }
            draw_f_group(0, 0, f_group, w, h);  //gruppen tegnes.
          popMatrix();
        }
      }
      x_of_current_C = new_x_coordinate;  //vi går videre til næste carbon og fortsætter loopet derfra.
      y_of_current_C = new_Ycoordinate;
    }
   }
  }

  //-----------------------------------------------DRAWING THE FUNCTIONAL GROUP-------------------------------------------------------------------//

  void draw_f_group (int X, int Y, int f_group, int w, int h) {   //tegner de forskellige grupper, by deafult: nedad
    switch(f_group) {
    case 1: //tegner alkohol
      line(X, Y, X, Y+30);            
      text("OH", X-7, Y+50);
      break;
    case 2: //tegner aldehyd
      line(X+5, Y, X+5, Y+30);        
      line(X-5, Y, X-5, Y+30);
      text("O", X-7, Y+50);
      line(X, Y, X - w + 10, (Y - (h / 2)));   
      text("H", X - w, (Y - (h / 2)) + 5);
      break;
    case 3: //tegner alkan
      break;
    case 4: //tegner alken
      line(X, Y + 4, X + w, (Y - (h / 2)) + 4);
      break;
    case 5: //tegner alkyn
      line(X, Y + 4, X + w, (Y - (h / 2)) + 4);    
      line(X, Y - 4, X + w, (Y - (h / 2)) - 4);
      break;
    case 6: //tegner keton
      line(X+5, Y, X+5, Y+30);       
      line(X-5, Y, X-5, Y+30);
      text("O", X-7, Y+50);
      break;
    }
  }
}
