program precti;
uses crt;

const
    souborJmenaM    = 'db_jmena_muzi.txt';
    souborJmenaZ    = 'db_jmena_zeny.txt';
    souborPrijmeni  = 'db_prijmeni.txt';
{ promenn' pro jm'na }
  type t_jmeno = record
    pohlavi : char;
    jmeno   : string[32];
  end;
var
  FjmenaM:Text;
  FjmenaZ:Text;
  Pjmena:integer;
  Ajmena: array [0..5000] of t_jmeno;
{ promenn' pro prójmeni}
var  
  Fprijmeni:Text;
  Pprijmeni:integer;
  Aprijmeni: array [0..5000] of string[64];
  
var rand, i:integer;

//function zmZenPrj(prijmeni:string)
function zenskePrijmeni(prijmeni: string):string;
  var 
    delkaS : integer;
    delkaT : integer;
    konec : string[2];
    konec1, konec2 : char;
    ova : boolean;
  begin
    delkaS:=length(prijmeni);//[0];
    
    zenskePrijmeni := copy(prijmeni, 1, delkaS-2);
    delkaT:=length(zenskePrijmeni);

    konec := copy(prijmeni, delkaS-1, 2); 
    konec1 := prijmeni[delkaS];
    konec2 := prijmeni[delkaS-1];
    
    case konec2 of
      'e':
        begin
          case konec1 of
            'k': insert('k', zenskePrijmeni, delkaT+1);
            'c': insert('c', zenskePrijmeni, delkaT+1);
            'l': insert('l', zenskePrijmeni, delkaT+1); 
          else
            insert(konec, zenskePrijmeni, delkaT+1);            
          end;
          delkaT:=length(zenskePrijmeni);
          insert('ov ', zenskePrijmeni, delkaT+1);
          exit; 
        end; 
    else
      //insert(konec, zenskePrijmeni, delkaT+1);
    end;
    
    insert(konec2, zenskePrijmeni, delkaT+1);    
    delkaT:=length(zenskePrijmeni);  
    
    case konec1 of
      'ì': 
        begin
          insert(' ', zenskePrijmeni, delkaT+1);
          exit;
        end;
      'a':
        begin
          insert('ov ', zenskePrijmeni, delkaT+1);
          exit;
        end;
    end;
    
    insert(konec1, zenskePrijmeni, delkaT+1);    
    delkaT:=length(zenskePrijmeni);
    insert('ov ', zenskePrijmeni, delkaT+1);
  end;


begin

  assign(FjmenaM, souborJmenaM);
  assign(FjmenaZ, souborJmenaZ);
  reset(FjmenaM);
  reset(FjmenaZ);
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
    
  assign(Fprijmeni, souborPrijmeni);
  reset(Fprijmeni);
  Pprijmeni:=0;
  while not eof(Fprijmeni) do
    begin
      readln(Fprijmeni, Aprijmeni[Pprijmeni]);
      Pprijmeni:=Pprijmeni+1;
    end;
  


  randomize;

while i<20 do
  begin
    rand := random(Pjmena);    
    
    if Ajmena[rand].pohlavi='z' then
      begin
        gotoxy(30, i+1);
        write(Ajmena[rand].pohlavi);    
        gotoxy(1, i+1);
        
        write(Ajmena[rand].jmeno);
        write(' ');
        
        rand := random(Pprijmeni);
        
        write(zenskePrijmeni(Aprijmeni[rand]));
        i:=i+1;      
      end;
    
  end;
  
  readln;
end.