program pn_02_prusecik_primek;
uses math;

{
Vstupem programu je osm celých čísel Ax, Ay, Bx, By, Cx, Cy, Dx, Dy
představujících souřadnice čtyř bodů A, B, C, D v Euklidovské rovině.

Program vytiskne odpověď TRUE, pokud úsečky AB a CD mají nějaký společný bod,
nebo FALSE, pokud úsečky AB a CD nemají žádný společný bod.

Například pro vstupní hodnoty: 0 0 1 1 0 1 1 0 bude odpověď TRUE.
}

type souradnice = record
    x,y:integer;
  end;
var p:array[0..3] of souradnice;
var u,v:souradnice;
var a,b,c,d: ^souradnice;
var nasobek:real;
var i:integer;
var t,f:string;

begin
  t := 'TRUE';
  f := 'FALSE';
  
  for i:=0 to 3 do
    with p[i] do begin
      read(x);
      read(y);
    end;

  a := @p[0];
  b := @p[1];
  c := @p[2];
  d := @p[3];
    
  u.x := a^.x - b^.x;
  u.y := a^.y - b^.y; 
  
  v.x := c^.x - d^.x;
  v.y := c^.y - d^.y;
  
  if (v.x = 0) and (u.x = 0) then
    begin
      if a^.x = c^.x  then write(t)
                      else write(f)
    end
  else if (v.y = 0) and (v.y = 0) then
    begin
      if a^.y = c^.y  then write(t)
                      else write(f)
    end
  else if (u.x = 0) or (u.y = 0) or (v.x = 0) or (v.y = 0) then write(t)
  else 
    begin
      if abs(floor(u.x / v.x * 100)) = abs(floor(u.y / v.y * 100))  then write(t)
                                          else write(f);
    end; 
    
end.