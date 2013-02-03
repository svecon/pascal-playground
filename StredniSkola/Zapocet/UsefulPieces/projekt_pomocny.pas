program EvidenceStudentuPomocnyProgram;
  {$MODE DELPHI}
  uses crt;

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
  end;
  var
    TSkupina  : Skupina;
    PSkupiny  : integer;
    FSkupiny  : file of Skupina;
    ASkupiny  : array[0..30] of Skupina;
{ Dalsi promenne }
  var
  i : integer;
    
begin
  
    assign(FSkupiny, souborPrefix+souborSkupiny+souborKoncovka);
    {$I-} reset(FSkupiny); {$I+} if IOResult=2 then rewrite(FSkupiny);
    PSkupiny := fileSize(FSkupiny); 
    
    { Vypsat všechno ze skupin
    for i:=0 to PSkupiny-1 do
      begin
        seek(FSkupiny, i);
        read(FSkupiny, ASkupiny[i]);
        gotoxy(10, i+1);
        write(ASkupiny[i].id);
        gotoxy(15, i+1);
        write(ASkupiny[i].nazev);
      end;
      } 
    
    assign(FStudenti, souborPrefix+souborStudenti+souborKoncovka);
    {$I-} reset(FStudenti); {$I+} if IOResult=2 then rewrite(FStudenti);
    PStudenti := fileSize(FStudenti);
    
    { Vypsat všechno ze studentu }
    for i:=0 to PStudenti-1 do
      begin
        seek(FStudenti, i);
        read(FStudenti, AStudenti[i]);
        gotoxy(5, i+1);
        write(AStudenti[i].id);
        gotoxy(10, i+1);
        write(AStudenti[i].idSkupiny);
        gotoxy(15, i+1);
        write(AStudenti[i].jmeno);
        write(' ');
        write(AStudenti[i].prijmeni);
        gotoxy(40, i+1);
        write(AStudenti[i].pohlavi);
        gotoxy(45, i+1);
        write(AStudenti[i].rocnik);
        write('.');
        write(AStudenti[i].trida);
        gotoxy(50, i+1);
        
        
      end;
   
    
    readln; 
end.