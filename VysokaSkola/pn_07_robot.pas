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

program pn_07_robot;

type Tsour = record
    x,y,z : integer;
  end;
  
var a {aktualni souradnice}, o {otoceni} : Tsour;
var instrukceS : string;
var instrukce : char;
var i : integer;
var px,py,pz : ^integer;
var sx,sy,sz : integer;

procedure otoc(var x : integer);
  begin
    x := -x;
  end;

procedure vynuluj(var s : Tsour);
  begin
    s.x := 0;
    s.y := 0;
    s.z := 0;
  end;

procedure vypis(var s : Tsour);
  begin
    with s do
      writeln(x, ' ', y, ' ', z);
  end;
  
procedure F;
  begin
    a.x := a.x + (o.x*sx);
    a.y := a.y + (o.y*sy);
    a.z := a.z + (o.z*sz);
  end;
  
procedure L;
  begin
         if (o.z =  sz) then begin pz^ := 0; px^ := -sx; end
    else if (o.x = -sx) then begin px^ := 0; pz^ := -sz; end
    else if (o.z = -sz) then begin pz^ := 0; px^ :=  sx; end
    else if (o.x =  sx) then begin px^ := 0; pz^ :=  sz; end;
  end;
  
procedure R;
  begin
         if (o.z =  sz) then begin pz^ := 0; px^ :=  sx; end
    else if (o.x = -sx) then begin px^ := 0; pz^ :=  sz; end
    else if (o.z = -sz) then begin pz^ := 0; px^ := -sx; end
    else if (o.x =  sx) then begin px^ := 0; pz^ := -sz; end;
  end;
  
procedure U;
  begin
         if (pz^ =  sz) then begin pz^ := 0; py^ :=  sy; end
    else if (py^ = -sy) then begin py^ := 0; pz^ :=  sz; end
    else if (pz^ = -sz) then begin pz^ := 0; py^ := -sy; end
    else if (py^ =  sy) then begin py^ := 0; pz^ := -sz; end;
  end;
  
procedure D;
  begin
         if (pz^ =  sz) then begin pz^ := 0; py^ := -sy; end
    else if (py^ = -sy) then begin py^ := 0; pz^ := -sz; end
    else if (pz^ = -sz) then begin pz^ := 0; py^ :=  sy; end
    else if (py^ =  sy) then begin py^ := 0; pz^ :=  sz; end;
  end;

procedure N;
  begin
         if (pz^ =  sz) then begin px := @o.y; py := @o.x; otoc(sx); end
    else if (px^ =  sx) then begin pz := @o.y; py := @o.z; otoc(sy); end
    else if (py^ =  sy) then begin px := @o.z; pz := @o.x; otoc(sy); end
    {else if (pz^ = -sz) then begin px := @o.y; py := @o.x; otoc(sy); end
    else if (px^ = -sx) then begin pz := @o.y; py := @o.z end
    else if (py^ = -sy) then begin px := @o.z; pz := @o.x end;}
  end;
  
procedure M;
  begin
  
  end;

begin
  instrukceS := 'FFLFRF<FRFUFF.';

  sx := 1;
  sy := 1;
  sz := 1;

  px := @o.x;
  py := @o.y;
  pz := @o.z;

  vynuluj(a);
  vynuluj(o);
  pz^ := 1;
  
  for i:=1 to length(instrukceS) do
    begin
      case instrukceS[i] of 
        '.': break;
        'F': F;
        'L': L;
        'R': R;
        'U': U;
        'D': D;
        '<': N;
        '>': M;
      end;
      write(instrukceS[i], ': ');
      vypis(a);
    end;
  
end.

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