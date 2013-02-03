{
Robot stoj� v poc�tku souradn� soustavy (souradnice [0,0,0]) a je otocen tak, �e doprava vede osa x, nahory osa y a dozadu a ve smeru pohledu osa z.

Pr�kazy robota jsou zad�v�ny p�smeny:
posun:
F...vpred, posune se o krok d�lky 1 ve smeru sv� orientace
otocen� (ot�c� se na m�ste, v�dy o 90 stupnu):
L...doleva
R...doprava
U...nahoru
D...dolu
<...na lev� bok
>...na prav� bok

Program cte ze vstupu znaky representuj�c� pr�kazy a po ka�d�m z nich vytiskne na zvl�tn� r�dek trojici cel�ch c�sel, oddelen�ch mezerou, ud�vaj�c� aktu�ln� polohu robota.
Vstup je ukoncen teckou ('.').

Pr�klad:
Vstup:
FFLFRF<FRFUFF.
V�stup:
0 0 1
0 0 2
0 0 2
-1 0 2
-1 0 2
-1 0 3
-1 0 3
-1 0 4
-1 0 4
-1 1 4
-1 1 4
-2 1 4
-3 1 4
}

program pn_07_robot_polarne;
uses math;

type Tsour = record
    x,y,z : integer;
  end;

procedure vypis(var s : Tsour);
  begin
    with s do
      writeln(x, ' ', y, ' ', z);
  end;

var a : Tsour;
var theta, phi : double;
var i : integer;
var instr : string;
var px,py,pz : ^integer;
var ch : char;
{var sx,sy,sz : integer;}

procedure F;
  begin
    px^ := px^ + round(1 * sin(phi) * cos(theta));
    pz^ := pz^ + round(1 * sin(phi) * sin(theta));
    py^ := py^ + round(1 * cos(phi));
  end;
  
procedure L;
  begin
    theta := theta + pi/2;
  end;

procedure R;
  begin
    theta := theta - pi/2;
  end;

procedure U;
  begin
    phi := phi + pi/2;
  end;
  
procedure D;
  begin
    phi := phi - pi/2;
  end;

procedure N;
  begin
    if abs(round(1 * sin(phi) * cos(theta))) = 1 then //px
      begin
        py := @a.z;
        pz := @a.y;
      end;
    if abs(round(1 * sin(phi) * sin(theta))) = 1 then //pz
      begin
        py := @a.x;
        px := @a.y;
      end;
    if abs(round(1 * cos(phi))) = 1 then //py
      begin
        pz := @a.x;
        px := @a.z;
      end;
      
  end;
  
procedure M;
  begin
    N;N;N;
  end;

begin
  a.x := 0;
  a.y := 0;
  a.z := 0;
  
  px := @a.x;
  py := @a.y;
  pz := @a.z;
  
  theta := pi/2;
  phi := pi/2;
  
  read(ch);
  while ch <> '.' do
    begin
      case ch of 
        '.': break;
        'F': F;
        'L': L;
        'R': R;
        'U': U;
        'D': D;
        '<': N;
        '>': M;
      end;
      vypis(a);
      runError(64000);
      read(ch);
    end;

end.
