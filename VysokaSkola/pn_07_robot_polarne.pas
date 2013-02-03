{
Robot stojí v pocátku souradné soustavy (souradnice [0,0,0]) a je otocen tak, že doprava vede osa x, nahory osa y a dozadu a ve smeru pohledu osa z.

Príkazy robota jsou zadávány písmeny:
posun:
F...vpred, posune se o krok délky 1 ve smeru své orientace
otocení (otácí se na míste, vždy o 90 stupnu):
L...doleva
R...doprava
U...nahoru
D...dolu
<...na levý bok
>...na pravý bok

Program cte ze vstupu znaky representující príkazy a po každém z nich vytiskne na zvláštní rádek trojici celých císel, oddelených mezerou, udávající aktuální polohu robota.
Vstup je ukoncen teckou ('.').

Príklad:
Vstup:
FFLFRF<FRFUFF.
Výstup:
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
      write(x, ' ', y, ' ', z);
  end;

var a : Tsour;
var theta, phi, Htheta, Hphi : double;
var i : integer;
var instr : string;
var px,py,pz : ^integer;
var ch : char;
var zx,zy,zz : integer;
var pzx, pzy, pzz : ^integer;

procedure vypisUhly;
  begin
    write(' # the: ', (theta/pi):2:2, ', phi: ', (phi/pi):2:2, ', Hthe: ', (Htheta/pi):2:2, ', Hphi: ', (Hphi/pi):2:2); 
  end;

procedure F;
  begin
    px^ := px^ + pzx^ * round(1 * sin(phi) * cos(theta));
    pz^ := pz^ + pzz^ * round(1 * sin(phi) * sin(theta));
    py^ := py^ + pzy^ * round(1 * cos(phi));
  end;
  
procedure L;
  begin
          if round(cos(Hphi)) =  1 then theta := theta + pi/2
    else  if round(cos(Hphi)) = -1 then theta := theta - pi/2
    else  if round(Htheta - theta - pi/2) = 0 then phi := phi + pi/2
    else  phi := phi - pi/2;
    
  end;

procedure R;
  begin
    L;L;L;
    {theta := theta - pi/2;}
  end;

procedure U;
  begin
    if (round(cos(phi)) = 0) and (round(cos(Hphi)) = 0) then
      begin
        theta := theta - pi/2;
        Htheta := Htheta - pi/2;
      end
    else 
      begin
        phi := phi - pi/2;
        Hphi := Hphi - pi/2;  
      end; 
  end;
  
procedure D;
  begin
    U;U;U;
    {phi := phi - pi/2;}
  end;

procedure N;
  var pom : double;
  begin
    pom := round(1 * sin(phi) * cos(theta));
    if abs(pom) = 1 then //px
      begin
        py := @a.z;
        pz := @a.y;
        pzy := @zz;
        pzz := @zy;
        if pom = 1        then zy := -zy
        else if pom = -1  then zz := -zz;
      end;
    pom := round(1 * sin(phi) * sin(theta));
    if abs(pom) = 1 then //pz
      begin
        py := @a.x;
        px := @a.y;
        pzx := @zy;
        pzy := @zx;
        if pom = 1        then zx := -zx
        else if pom = -1  then zy := -zy;
      end;
    pom := round(1 * cos(phi));      
    if abs(pom) = 1 then //py
      begin
        pz := @a.x;
        px := @a.z;
        pzx := @zz;
        pzz := @zx;
        if pom = 1        then zz := -zz
        else if pom = -1  then zx := -zx;
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
  
  zx := 1;
  zy := 1;
  zz := 1;
  
  pzx := @zx;
  pzy := @zy;
  pzz := @zz;
  
  px := @a.x;
  py := @a.y;
  pz := @a.z;
  
  theta := pi/2;
  phi := pi/2;
  
  Htheta := pi/2;
  Hphi := 0;
  
  read(ch);
  while ch <> '.' do 
    begin
      ch := upcase(ch);
      case ch of 
        '.': break;
        'F': F;
        'L': L;
        'R': R;
        'U': U;
        'D': D;
        '<': N;
        '>': M;
        else begin read(ch); continue; end;
      end;
      {write(ch, ': ');}
      vypis(a);
      read(ch);
      {vypisUhly;}
      writeln;
    end;

end.

{
 x := rho * sin phi * cos theta
 z := rho * sin phi * sin theta
 y := rho * cos phi
}

{
FFLFRF<FRFUFF.

F: 0 0 1
F: 0 0 2
L: 0 0 2
F: -1 0 2
R: -1 0 2
F: -1 0 3
<: -1 0 3
F: -1 0 4
R: -1 0 4
F: -1 1 4
U: -1 1 4
F: -2 1 4
F: -3 1 4

}