program EvidenceStudentu;
  {$MODE DELPHI}
  uses crt, sysutils;

{ DEFINICE konstant }
  const
    programVyska    = 55;
    programSirka    = 160;
    mezera          = 10;
    souborPrefix    = 'data_';
    souborKoncovka  = '.dat';
    souborSkupiny   = 'skupiny';
    souborStudenti  = 'studenti';
    souborLekce     = 'lekce';
    souborAbs       = 'absence';
    
    znakMezera      = ' ';
    znakMenuVyber   = '*';
    
    znakSvisly      = '|';
    znakVodorovny   = '-';
    znakRohovy      = '+';

    souborJmenaM    = 'db_jmena_muzi.txt';
    souborJmenaZ    = 'db_jmena_zeny.txt';
    souborPrijmeni  = 'db_prijmeni.txt';
    
{ MENU klavesy }
  {http://htmlhelp.com/reference/charset/iso064-095.html}
	KeyUp			  = chr(72);
	KeyDown			= chr(80);
	KeyEnter		= chr(13);
	KeySpace		= chr(32);
  KeyEsc			= chr(27);
  Key_X       = chr(88);

{ DEFINICE studentu }
  type abecedaRozsah = 'A'..'Z';
  var abecedaPole : array[0..30] of abecedaRozsah;

  type Student = record
    id        : integer;
    idSkupiny : integer;
    jmeno     : string[32];
    prijmeni  : string[32];
    pohlavi   : char;
    rocnik    : smallint;
    trida     : abecedaRozsah;
    //body      : integer;
    ucast     : integer;
    absence   : integer;
    absProc   : real;
  end;
  var 
    TStudent  : Student;
    PStudenti : integer;
    FStudenti : file of Student;
    AStudenti : array[0..1000] of Student;  

{ DEFINICE skupin }
  type Skupina = record
    id        : integer;
    nazev     : string[32];
    pocet     : integer;
  end;
  var
    TSkupina  : Skupina;
    PSkupiny  : integer;
    FSkupiny  : file of Skupina;
    ASkupiny  : array[0..30] of Skupina;

{ DEFINICE nahodnych jmen }
  type t_jmeno = record
    pohlavi : char;
    jmeno   : string[32];
  end;
  var
    FjmenaM   : Text;
    FjmenaZ   : Text;
    Pjmena    : integer;
    Ajmena    : array [0..5000] of t_jmeno;
{ DEFINICE nahodnych prijmeni}
  var  
    Fprijmeni : Text;
    Pprijmeni : integer;
    Aprijmeni : array [0..500] of string[32];
{ DEFINICE data a casu}
  type t_datetime = record
    YY,MM,DD, HH,II,SS,MS : Word;
  end;
{ DEFINICE lekcí}
  type t_lekce = record
    id             : integer;
    idSkupiny      : integer;
    datum_vlozena  : t_datetime;
    datum_probehla : t_datetime;
  end;
  var  
    Flekce : file of t_lekce;
    Plekce : integer;
    Tlekce : t_lekce;
    Alekce : array [0..500] of t_lekce;
    TDateTime : t_datetime;
{ DEFINICE absence}
  type t_absence = record
    idLekce        : integer;
    idStudenta     : integer;
    idSkupiny      : integer;
    ucast          : smallint;
  end;
  var  
    Fabs : file of t_absence;
    Pabs : integer;
    Tabs : t_absence;
    Aabs : array [0..1000] of t_absence;

{ PROMENNE dalsi}
  var 
    {menu}
  konecMenuSeznamSkupin       : boolean;
  konecMenuSeznamSkupinAkce   : boolean;
  konecMenuSkupiny            : boolean;
  konecMenuSkupinyAkce        : boolean;
  konecMenuStudent            : boolean;
  konecMenuStudentAkce        : boolean;
    {pozicovani na stred}
  vyskaOkna     : integer;
  offX, offY    : integer;
  i             : integer;  

{ DEFINICE procedur a funkcí }
procedure writeDate (d : t_datetime );
  begin
    //d.HH,d.II,d.SS,d.MS);
    if d.DD<10 then write('0');
    write(d.DD, '.');
    if d.MM<10 then write('0');
    write(d.MM, '.');
    write(d.YY);
    
    write(' ');
    if d.HH<10 then write('0');
    write(d.HH, ':');
    if d.II<10 then write('0');
    write(d.II);
  end;

procedure vytvoritAbecedu;
  var 
    i : integer;
    A,Z : integer;
  begin
    A := ord('A');
    Z := ord('Z');
    for i:=A to Z do
      begin
        abecedaPole[i-A]:=Chr(i);
      end;    
  end;

function zenskePrijmeni(prijmeni: string) :string;
  var 
    delkaS : integer;
    delkaT : integer;
    konec : string[2];
    konec1, konec2 : char;
    ova : boolean;
    zPrijmeni : string[32];
  begin
    delkaS:=length(prijmeni);
    
    zPrijmeni := copy(prijmeni, 1, delkaS-2);
    delkaT:=length(zPrijmeni);

    konec := copy(prijmeni, delkaS-1, 2); 
    konec1 := prijmeni[delkaS];
    konec2 := prijmeni[delkaS-1];
    
    case konec2 of
      'e':
        begin
          case konec1 of
            'k': insert('k', zPrijmeni, delkaT+1);
            'c': insert('c', zPrijmeni, delkaT+1);
            'l': insert('l', zPrijmeni, delkaT+1); 
          else
            insert(konec, zPrijmeni, delkaT+1);            
          end;
          delkaT:=length(zPrijmeni);
          insert('ov ', zPrijmeni, delkaT+1);
          zenskePrijmeni := zPrijmeni;
          exit; 
        end; 
    else
      //insert(konec, zPrijmeni, delkaT+1);
    end;
    
    insert(konec2, zPrijmeni, delkaT+1);    
    delkaT:=length(zPrijmeni);  
    
    case konec1 of
      'ì': 
        begin
          insert(' ', zPrijmeni, delkaT+1);
          zenskePrijmeni := zPrijmeni;
          exit;
        end;
      'a':
        begin
          insert('ov ', zPrijmeni, delkaT+1);
          zenskePrijmeni := zPrijmeni;
          exit;
        end;
    end;
    
    insert(konec1, zPrijmeni, delkaT+1);    
    delkaT:=length(zPrijmeni);
    insert('ov ', zPrijmeni, delkaT+1);
    
    zenskePrijmeni := zPrijmeni;
  end;

procedure smazatOkno (smazat : boolean = true);
  begin
    window(1, 1, programSirka, programVyska);
    if smazat then clrscr;
  end;

procedure narysujOkno(vyska:integer; smazat:boolean=true);
  var sirka, vrch, i: integer;
  var znak:char;
  begin
    smazatOkno(smazat);
    offY := round((programVyska-vyska)/2);
    sirka:=programSirka-(2*offX);
    gotoxy(mezera, offY); for i:=0 to sirka do write(znakVodorovny);
    gotoxy(mezera, offY+vyska); for i:=0 to sirka do write(znakVodorovny);
    for i:=0 to vyska do
      begin
        if (i=0) or (i=vyska) then znak:=znakRohovy
        else znak:=znakSvisly;
        gotoxy(mezera, offY+i); write(znak);
        gotoxy(mezera+sirka, offY+i); write(znak);
      end;
    window(offX+2, offY+2, offX+sirka-2, offY+vyska-2);  
  end;

function vyprazdniSkupinu (idSkupiny: integer) : boolean;
  var
    i : integer;
    novyPocet : integer;
    pismeno : char;
  begin
    vyprazdniSkupinu := false;
    vyskaOkna := 5;
    narysujOkno(vyskaOkna);
    gotoxy(1, 1);
    write('Opravdu chcete smazat vsechny studenty v teto skupine? [A/N]');
    repeat
      pismeno := readkey;
      pismeno := upcase(pismeno);
    until (pismeno='A') or (pismeno='N') or (pismeno='X');
    if (pismeno='N') or (pismeno='X') then exit;
    
    novyPocet := 0;
    for i:=0 to PStudenti-1 do
      begin
        if AStudenti[i].idSkupiny<>idSkupiny then
          begin
            AStudenti[novyPocet] := AStudenti[i];
            novyPocet := novyPocet +1;  
          end;
      end;
    ASkupiny[idSkupiny].pocet := 0;
    PStudenti := novyPocet;
    
    vyprazdniSkupinu := true;
  end;

procedure vyplnitSkupinu (idSkupiny:integer);
  var
    i, j, k, l : integer;
    randJmeno, randPrijmeni : integer;
    pocet : integer;
    smazano : boolean;
  begin
    smazano := vyprazdniSkupinu(idSkupiny);
    
    vyskaOkna := 5;
    narysujOkno(vyskaOkna);
    gotoxy(1, 1);
    write('Kolik nezivych bytosti si prejte vytvorit? ');
    read(pocet);
    
    for i:=0 to pocet-1 do
      begin

        randJmeno := random(4890);
        randPrijmeni := random(395);
        
        if PStudenti=0 then TStudent.id := 0
        else TStudent.id := AStudenti[PStudenti-1].id +1;
                
        TStudent.idSkupiny := idSkupiny;
        
        TStudent.jmeno := AJmena[randJmeno].jmeno;
        TStudent.pohlavi := AJmena[randJmeno].pohlavi;
        
        if AJmena[randJmeno].pohlavi='m' then TStudent.prijmeni := APrijmeni[randPrijmeni]
        else TStudent.prijmeni := zenskePrijmeni(APrijmeni[randPrijmeni]);
        
        TStudent.rocnik := random(4)+1;
        //TStudent.body := random(1000);
        TStudent.absence := 0;
        TStudent.ucast := 0;
        TStudent.absProc := 0;
        TStudent.trida := abecedaPole[random(4)]; 
    
        AStudenti[PStudenti] := TStudent;        
        PStudenti := PStudenti + 1;
      end;
    
    if smazano then ASkupiny[idSkupiny].pocet := pocet
    else ASkupiny[idSkupiny].pocet := pocet + ASkupiny[idSkupiny].pocet;      
  end;
  
procedure seraditStudenty(typRazeni : string);
  var
    i, j : integer;
    
  begin
    for i:=0 to PStudenti-2 do
      begin
        for j:=0 to PStudenti-2 do
          begin
            if 
              ((typRazeni='abecedne') AND (AStudenti[j].prijmeni > AStudenti[j+1].prijmeni))
           OR ((typRazeni='absence')  AND (AStudenti[j].absProc  > AStudenti[j+1].absProc))
              then
              begin
                TStudent := AStudenti[j];
                AStudenti[j] := AStudenti[j+1];
                AStudenti[j+1] := TStudent;
              end;
          end;      
      end;
  end;

procedure poziceZvetsit (var i:integer; max:integer);
  begin
    i:=i+1;
    if i>max then i:=0;
  end;

procedure poziceZmensit (var i:integer; max:integer);
  begin
    i:=i-1;
    if i<0 then i:=max;
  end;

procedure nacistDatabaziJmen;
  begin
    assign(FjmenaM, souborJmenaM);
    assign(FjmenaZ, souborJmenaZ);
    assign(Fprijmeni, souborPrijmeni);
    reset(FjmenaM);
    reset(FjmenaZ);
    reset(Fprijmeni);
    
    Pjmena:=0;
    while not eof(FjmenaM) do
      begin
        readln(FjmenaM, Ajmena[Pjmena].jmeno);
        Ajmena[Pjmena].pohlavi := 'm';
        Pjmena:=Pjmena+1;
      end;
    while not eof(FjmenaZ) do
      begin
        readln(FjmenaZ, Ajmena[Pjmena].jmeno);
        Ajmena[Pjmena].pohlavi := 'z';
        Pjmena:=Pjmena+1;
      end;
      
    Pprijmeni:=0;
    while not eof(Fprijmeni) do
      begin
        readln(Fprijmeni, Aprijmeni[Pprijmeni]);
        Pprijmeni:=Pprijmeni+1;
      end;

    close(FjmenaM);
    close(FjmenaZ);
    close(Fprijmeni);
  end;

procedure nacistSkupiny;
  var i:integer;
  begin
    assign(FSkupiny, souborPrefix+souborSkupiny+souborKoncovka);
    {$I-} reset(FSkupiny); {$I+} if IOResult=2 then rewrite(FSkupiny);
    PSkupiny := fileSize(FSkupiny);
    for i:=0 to PSkupiny-1 do
      begin
        seek(FSkupiny, i);
        read(FSkupiny, ASkupiny[i]);
        ASkupiny[i].pocet := 0;
      end;
    close(FSkupiny); 
  end;
  
procedure nacistStudenty;
  var i:integer;
  begin
    assign(FStudenti, souborPrefix+souborStudenti+souborKoncovka);
    {$I-} reset(FStudenti); {$I+} if IOResult=2 then rewrite(FStudenti);
    PStudenti := fileSize(FStudenti);
    for i:=0 to PStudenti-1 do
      begin
        seek(FStudenti, i);
        read(FStudenti, AStudenti[i]);
        ASkupiny[AStudenti[i].idSkupiny].pocet := 1 + ASkupiny[AStudenti[i].idSkupiny].pocet; 
      end;
    close(FStudenti); 
  end;
  
procedure nacistLekce;
  var i:integer;
  begin
    assign(Flekce, souborPrefix+souborLekce+souborKoncovka);
    {$I-} reset(Flekce); {$I+} if IOResult=2 then rewrite(Flekce);
    Plekce := fileSize(Flekce);
    for i:=0 to Plekce-1 do
      begin
        seek(Flekce, i);
        read(Flekce, Alekce[i]);
      end;
    close(Flekce); 
  end;
  
procedure nacistAbsenci;
  var i:integer;
  begin
    assign(Fabs, souborPrefix+souborAbs+souborKoncovka);
    {$I-} reset(Fabs); {$I+} if IOResult=2 then rewrite(Fabs);
    Pabs := fileSize(Fabs);
    for i:=0 to Pabs-1 do
      begin
        seek(Fabs, i);
        read(Fabs, Aabs[i]);
      end;
    close(Fabs); 
  end;

procedure novaSkupina;
  begin
    vyskaOkna := 5;
    narysujOkno(vyskaOkna);
    gotoxy(1, 1);
    write('Nazev skupiny: '); readln(TSkupina.nazev);
    if PSkupiny=0 then TSkupina.id := 0
    else TSkupina.id := ASkupiny[PSkupiny-1].id +1;
    TSkupina.pocet := 0;
    ASkupiny[PSkupiny]:=TSkupina;
    PSkupiny := PSkupiny+1;
  end;
  
procedure novyStudent(idSkupiny : integer);
  begin
    vyskaOkna := 15;
    narysujOkno(vyskaOkna);
    gotoxy(1, 1);
    write('Jmeno studenta: '); readln(TStudent.jmeno);
    write('Prijmeni: '); readln(TStudent.prijmeni);
    write('Pohlavi <m/z>: '); readln(TStudent.pohlavi);
    write('Rocnik <1-4>: '); readln(TStudent.rocnik);
    write('Trida <A-Z>: '); readln(TStudent.trida);
    TStudent.trida := upcase(TStudent.trida);
    
    if PStudenti=0 then TStudent.id := 0
    else TStudent.id := AStudenti[PStudenti-1].id +1;
    //TStudent.body := 0;
    TStudent.absence := 0;
    TStudent.absProc := 0;
    TStudent.ucast := 0;
    TStudent.idSkupiny := idSkupiny;
    
    AStudenti[PStudenti]:=TStudent;
    PStudenti := PStudenti+1;
    
    ASkupiny[TStudent.idSkupiny].pocet := 1 + ASkupiny[TStudent.idSkupiny].pocet;
    
    write(TStudent.jmeno, ' ', TStudent.prijmeni, ' ', TStudent.rocnik, '.', TStudent.trida);
    readln;
    
    //pohlavi   : char;
    //rocnik    : smallint;
    //trida     : char;
  end;

procedure ulozSkupiny;
  var i:integer;
  begin
    assign(FSkupiny, souborPrefix+souborSkupiny+souborKoncovka);
    rewrite(FSkupiny);
    for i:=0 to PSkupiny-1 do
      begin
        seek(FSkupiny, i);
        write(FSkupiny, ASkupiny[i]);
      end;
    close(FSkupiny);
  end;
  
procedure ulozStudenty;
  var i:integer;
  begin
    assign(FStudenti, souborPrefix+souborStudenti+souborKoncovka);
    rewrite(FStudenti);
    for i:=0 to PStudenti-1 do
      begin
        seek(FStudenti, i);
        write(FStudenti, AStudenti[i]);
      end;
    close(FStudenti);
  end;

procedure ulozAbsenci;
  var i:integer;
  begin
    assign(Fabs, souborPrefix+souborAbs+souborKoncovka);
    rewrite(Fabs);
    for i:=0 to Pabs-1 do
      begin
        seek(Fabs, i);
        write(Fabs, Aabs[i]);
      end;
    close(Fabs);
  end;
  
procedure ulozLekce;
  var i:integer;
  begin
    assign(Flekce, souborPrefix+souborLekce+souborKoncovka);
    rewrite(Flekce);
    for i:=0 to Plekce-1 do
      begin
        seek(Flekce, i);
        write(Flekce, Alekce[i]);
      end;
    close(Flekce);
  end;

procedure smazatSkupinu (id :integer);
  var
    i : integer;
    ch : char;
    PStudentiTemp : integer;
  begin
    narysujOkno(10);
    gotoxy(1, 1);
    writeln('Opravdu chcete smazat skupinu "', ASkupiny[id].nazev ,'"? [A/N]');
    repeat
      ch := readkey;
      ch := upcase(ch);
    until (ch='A') or (ch='N') or (ch='X');
    if (ch='N') or (ch='X') then exit;
    
    for i:=id to PSkupiny-2 do
      begin
        ASkupiny[i] := ASkupiny[i+1];
      end;
    PSkupiny := PSkupiny -1;
    
    // mazání studentu ve skupine
    PStudentiTemp := 0;
    for i:=0 to PStudenti-1 do
      begin
        if AStudenti[i].idSkupiny <> id then
          begin
            AStudenti[PStudentiTemp] := AStudenti[i];
            PStudentiTemp := PStudentiTemp +1;
          end;  
      end;
    PStudenti := PStudentiTemp;
       
    
    konecMenuSkupiny := true;
  end;

procedure prepocitatAbsenci();
  var i,j : integer;
  begin

  for j:=0 to PStudenti-1 do
    begin
      AStudenti[j].absence := 0; 
      AStudenti[j].ucast := 0;
      AStudenti[j].absProc := 0;
    end;
  
    for i:=0 to Pabs-1 do
      begin
        for j:=0 to PStudenti-1 do
          begin
            if AStudenti[j].id = Aabs[i].idStudenta then
              begin
              
                if Aabs[i].ucast = 0 then
                  begin
                    AStudenti[j].absence := AStudenti[j].absence+1; 
                  end
                else
                  begin
                    AStudenti[j].ucast := AStudenti[j].ucast+1; 
                  end;
                
                AStudenti[j].absProc := AStudenti[j].ucast / (AStudenti[j].ucast + AStudenti[j].absence) * 100;
                              
              end;
          end;
      end;
  
  end;

procedure studentDochazka(idStudent, idSkupiny : integer);
  var i,j : integer;
  var ch: char;
  var nenalezen : boolean;
  var vyska : integer;
  begin
 
  vyska := 0;
  for i:=0 to Plekce-1 do 
    begin
      if Alekce[i].idSkupiny = idSkupiny then
        begin
          vyska := vyska+1;  
        end;  
    end;
 
   narysujOkno(vyska+30);
   
   i:=0; nenalezen:=false;
   repeat
      if AStudenti[i].id = idStudent then
        begin
          TStudent := AStudenti[i];
          nenalezen := true;
        end;
      i:=i+1;
   until nenalezen;
   
   writeln(TStudent.jmeno, ' ', TStudent.prijmeni, ', dochazka:');
   writeln;
   
  for i:=0 to Plekce-1 do 
    begin
      if Alekce[i].idSkupiny = idSkupiny then
        begin
          writeDate(Alekce[i].datum_probehla);
          write(': ');
          for j:=0 to Pabs-1 do
            begin
              if (Aabs[j].idStudenta = idStudent) and (Aabs[j].idSkupiny = idSkupiny) and (Aabs[j].idLekce = Alekce[i].id) then
                begin
                  if Aabs[j].ucast = 1 then writeln('Ano!')
                  else writeln('Ne!');
                end;
            end;  
        end;  
    end;
 
    repeat
      ch := readkey;
      ch := upcase(ch);
    until (ch='X');
  end;

procedure menuStudentVyber (id, pocetStudentuVeSkupine: integer; student_akce : array of integer; absence : boolean = false; idLekce : integer = 0);
  var ch:char;
  var i, pozice:integer;
  var student_abs : array[0..50] of integer;
  begin
    konecMenuStudent:=false;
    konecMenuStudentAkce := false;
    pozice := 0;
    repeat
      {smazat vsechny hvezdicky}
      for i:=0 to pocetStudentuVeSkupine-1 do
        begin
          gotoxy(1, (i*2)+4);
          write(znakMezera);
        end;
      {jedna hvezdicka}
      gotoxy(1, (pozice*2)+4);
      write(znakMenuVyber);
      
      ch:=upcase(readkey);
      case ch of
        KeyUp:
          begin
            poziceZmensit(pozice, pocetStudentuVeSkupine-1);
          end;
        KeyDown:
          begin
            poziceZvetsit(pozice, pocetStudentuVeSkupine-1);
          end;
        'A':
          begin
            if absence then
              begin
                student_abs[pozice] := 1;
                gotoxy(55, (pozice*2)+4);
                write('Zde!  ');
                poziceZvetsit(pozice, pocetStudentuVeSkupine-1);  
              end;
          end;
        'N':
          begin
            if absence then
              begin
                student_abs[pozice] := 0;
                gotoxy(55, (pozice*2)+4);
                write('Chybi!');
                poziceZvetsit(pozice, pocetStudentuVeSkupine-1); 
              end;
          end;
        KeyEnter:
          begin
            if absence then
              begin
                for i:=0 to pocetStudentuVeSkupine-1 do
                  begin
                    Tabs.idLekce := idLekce;
                    Tabs.idStudenta := student_akce[i];
                    Tabs.idSkupiny := id;
                    Tabs.ucast := student_abs[i];
                    Aabs[Pabs] := Tabs;
                    Pabs := Pabs+1; 
                  end;
                Alekce[Plekce] := Tlekce;
                Plekce := Plekce+1;
              end
            else
              begin
                studentDochazka(student_akce[pozice], id);
              end;
            konecMenuStudentAkce := true;
          end;
        KeyEsc, Key_X:
          begin
            konecMenuStudent := true;
          end;
      end;
    until konecMenuStudent or konecMenuStudentAkce;
  end;

procedure seznamStudentu(idSkupiny : integer; typRazeni : string; absence : boolean = false; idLekce : integer = 0);
  var 
    i, j : integer;
    pismeno : char;
    student_akce : array[0..50] of integer;
  begin
    narysujOkno(6+ASkupiny[idSkupiny].pocet*2);
    prepocitatAbsenci();
    seraditStudenty(typRazeni);
    
    writeln('Pocet studentu ve skupine: ', ASkupiny[idSkupiny].pocet);
    
    j:=1;
    for i:=0 to PStudenti-1 do
      begin
        if AStudenti[i].idSkupiny=idSkupiny then
          begin
            j:=j+1;
            gotoxy(7, j*2);
            write(AStudenti[i].prijmeni);
            gotoxy(22, j*2);
            write(AStudenti[i].jmeno);
            gotoxy(37, j*2);
            write(AStudenti[i].rocnik, AStudenti[i].trida);
            gotoxy(45, j*2);
            write(AStudenti[i].absProc:2:2, '%');
            
            student_akce[j-2] := AStudenti[i].id;
          end;
      end;

    menuStudentVyber(idSkupiny, ASkupiny[idSkupiny].pocet, student_akce, absence, idLekce);

  end;

procedure zapsatAbsenci (idSkupiny : integer);
  var ch: char;
  begin
    narysujOkno(4);
    write('Vyplnujete absenci v hodine? [A/N]');
    repeat
      ch:=readkey;
      ch:=upcase(ch);
    until (ch='A') OR (ch='N');
    
    DeCodeDate(Date,TDateTime.YY,TDateTime.MM,TDateTime.DD);
    DecodeTime(Time,TDateTime.HH,TDateTime.II,TDateTime.SS,TDateTime.MS);
    
    Tlekce.datum_vlozena := TDateTime;
    
    if ch='A' then
      begin
        Tlekce.datum_probehla := TDateTime;
      end
    else
      begin
        narysujOkno(10);
        writeln('Kdy probehla hodina?');
        write('Rok: ');
        readln(TDateTime.YY);
        write('Mesic: ');
        readln(TDateTime.MM); 
        write('Den: ');
        readln(TDateTime.DD); 
        write('Hodina: ');
        readln(TDateTime.HH);
        TDateTime.II := 0;
        TDateTime.SS := 0;
        TDateTime.MS := 0;
        
        Tlekce.datum_probehla := TDateTime;        
      end;
    
    if Plekce=0 then Tlekce.id := 0
    else Tlekce.id := Alekce[Plekce-1].id +1;  
     
    Tlekce.idSkupiny := idSkupiny;
    
    seznamStudentu(idSkupiny, 'abecedne', true, Tlekce.id);
  
  end;

procedure ulozVsechno;
  begin
    ulozSkupiny();
    ulozStudenty();
    ulozLekce();
    ulozAbsenci();
  end;

procedure prehledHodin(idSkupiny: integer);
  var vyska : integer;
  var i : integer;
  var ch : char;
  begin
  
  vyska := 0;
  for i:=0 to Plekce-1 do 
    begin
      if Alekce[i].idSkupiny = idSkupiny then
        begin
          vyska := vyska+1;  
        end;  
    end;
 
   narysujOkno(vyska+5);

   writeln('Prehled hodin skupiny:');
   
  for i:=0 to Plekce-1 do 
    begin
      if Alekce[i].idSkupiny = idSkupiny then
        begin
          gotoxy(2, i+3);
          write(i+1, '.');
          gotoxy(7, i+3);
          writeDate(Alekce[i].datum_probehla);  
        end;  
    end;
  
    repeat
      ch := readkey;
      ch := upcase(ch);
    until (ch='X');
  end;

procedure menuSkupinyVykonej (idSkupiny, pozice:integer);
  begin
    case pozice of
      0: 
        begin
          konecMenuSkupiny := true;
        end;
      1:
        begin
          smazatSkupinu(idSkupiny);
        end;
      2:
        begin
          novyStudent(idSkupiny);
        end;     
      3:        
        begin
          vyplnitSkupinu(idSkupiny);
        end;
      4:        
        begin
          vyprazdniSkupinu(idSkupiny);
        end;
      5:
        begin
          seznamStudentu(idSkupiny, 'abecedne');
        end;
      6:
        begin
          seznamStudentu(idSkupiny, 'absence');
        end;
      7:
        begin
          prehledHodin(idSkupiny);
        end;
      8:
        begin
          zapsatAbsenci(idSkupiny);
        end;
    end;
  end;

procedure menuSkupinyVyber (id, pocetAkci: integer);
  var ch:char;
  var i, pozice:integer;
  begin
    konecMenuSkupiny:=false;
    konecMenuSkupinyAkce := false;
    pozice := 0;
    repeat
      {smazat vsechny hvezdicky}
      for i:=0 to pocetAkci do
        begin
          gotoxy(1, (i*2)+1);
          write(znakMezera);
        end;
      {jedna hvezdicka}
      gotoxy(1, (pozice*2)+1);
      write(znakMenuVyber);
      
      ch:=upcase(readkey);
      case ch of
        KeyUp:
          begin
            poziceZmensit(pozice, pocetAkci);
          end;
        KeyDown:
          begin
            poziceZvetsit(pozice, pocetAkci);
          end;
        KeyEnter, KeySpace:
          begin
            menuSkupinyVykonej(id, pozice);
            konecMenuSkupinyAkce := true;
          end;
        KeyEsc, Key_X:
          begin
            konecMenuSkupiny := true;
          end;
      end;
    until konecMenuSkupiny or konecMenuSkupinyAkce;
  end;

procedure menuSkupiny (id: integer);
  var
    akce : array[0..10] of String;
    i : integer;
    pocetAkci : integer;
  begin
      {pocitani offSetu + graficke okno na stredu}
    vyskaOkna:= (10+2)*2;
    narysujOkno(vyskaOkna);
    akce[0] := 'Zpet na menu skupin';
    akce[1] := 'Smazat skupinu';
    akce[2] := 'Novy student';
    akce[3] := 'Vyplnit skupinu nahodnymi studenty';
    akce[4] := 'Vyprazdnit skupinu';
    akce[5] := 'Zobrazit seznam [abeceda]';
    akce[6] := 'Zobrazit seznam [absence]';    
    akce[7] := 'Zobrazit prehled hodin';
    akce[8] := 'Zapsat absenci skupiny';
    pocetAkci := 9;
    
    for i:=0 to pocetAkci-1 do
      begin
        gotoxy(5, (i*2)+1);
        write(akce[i]);
      end;
    menuSkupinyVyber(id, pocetAkci-1);
  end;

procedure menuSeznamSkupinVykonej (pozice:integer);
  begin
    case pozice of
      0: 
        begin
          novaSkupina;
        end;
      else
        begin
          repeat
            menuSkupiny(pozice-1);
          until konecMenuSkupiny;
          
        end;
    end;
  end;

procedure menuSeznamSkupinVyber;
  var ch:char;
  var i, pozice:integer;
  begin
    konecMenuSeznamSkupin:=false;
    konecMenuSeznamSkupinAkce := false;
    pozice := 0;
    repeat
      {smazat vsechny hvezdicky}
      for i:=0 to PSkupiny do
        begin
          gotoxy(1, (i*2)+1);
          write(znakMezera);
        end;
      {jedna hvezdicka}
      gotoxy(1, (pozice*2)+1);
      write(znakMenuVyber);
      
      ch:=upcase(readkey);
      case ch of
        KeyUp:
          begin
            poziceZmensit(pozice, PSkupiny);
          end;
        KeyDown:
          begin
            poziceZvetsit(pozice, PSkupiny);
          end;
        KeyEnter, KeySpace:
          begin
            menuSeznamSkupinVykonej(pozice);
            konecMenuSeznamSkupinAkce := true;
          end;
        KeyEsc, Key_X:
          begin
            konecMenuSeznamSkupin := true;
          end;
      end;
    until konecMenuSeznamSkupin or konecMenuSeznamSkupinAkce;
  end;

procedure menuSeznamSkupin;
  var i:integer;
  begin
      {pocitani offSetu + graficke okno na stredu}
    vyskaOkna:= (PSkupiny+2)*2;
    narysujOkno(vyskaOkna);
      {VYPIS skupiny + dalsi akce}
    for i:=0 to PSkupiny do
      begin
        if i=0 then 
          begin
            gotoxy(8, (i*2)+1);
            write('Nova skupina');
          end
        else
          begin
            gotoxy(3, (i*2)+1);
            write(i:2, '. ');
            write(ASkupiny[i-1].nazev);
          end;        
      end;
      {aktivace menu}
    menuSeznamSkupinVyber();
  end;

procedure setup;
  begin
    vytvoritAbecedu();
    nacistSkupiny();
    nacistStudenty();
    nacistLekce();
    nacistAbsenci();
    nacistDatabaziJmen();
    offX := round(mezera);
  end;

begin
  randomize();
  setup();
  
  repeat
    menuSeznamSkupin();
  until konecMenuSeznamSkupin;
  
  ulozVsechno();
end.