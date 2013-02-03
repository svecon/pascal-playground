{
Program najde nejdel�� radu, jakou lze postavit ze zadan�ch kostek domina a vytiskne jej� d�lku. Kostky lze pri pripojov�n� otocit.

Kostky domina maj� sv� pol�cka ohodnocen� hodnotami v rozsahu 1..38, pocet kostek je nejv��e 16.

Vstupem programu je pocet kostek N (nejv��e 16) a potom N dvojic c�sel z rozsahu 1..38 popisuj�c� jednotliv� kosticky.

Napr�klad pro vstup:

5  1 2  1 2  2 3  2 17  2 17
Bude odpov�daj�c� v�stup:

5
Tzn. nejdel�� rada, kterou ze zadan�ch kostek mu�eme sestavit (napr�klad 2-1 1-2 2-17 17-2 2-3), m� d�lku 5.
}

program pn_08_domino;

const MAX = 38;

var n,x,y,i,j : integer;
var m : array [1..MAX, 1..MAX] of integer;
var maxH : integer;

procedure spojuj(x,y,hloubka : integer);
  var i,j : integer;
  begin
    if hloubka > maxH then maxH := hloubka;
    
    for i:=1 to MAX do
      if      m[y, i] > 0 then
        begin
          dec(m[y,i]);
          spojuj(y, i, hloubka +1);
          spojuj(i, y, hloubka +1);
          inc(m[y,i]);
        end
      else if m[i, y] > 0 then
        begin
          dec(m[i,y]);
          spojuj(i, y, hloubka +1);
          spojuj(y, i, hloubka +1);
          inc(m[i,y]);
        end;
    
  end;

begin
  maxH := 0;
  
  for i:=1 to MAX do
    for j:=1 to MAX do
      m[i,j] := 0;
  
  read(n);
  for i:=1 to n do
    begin
      read(x,y);
      inc(m[x,y]);
    end;

  for i:=1 to MAX do
    for j:=1 to MAX do
      if m[i,j] > 0 then
        begin
          dec(m[i,j]);
          spojuj(i,j,1);
          spojuj(j,i,1);
          inc(m[i,j]);
        end;
        
  write(maxH);
    
end.
