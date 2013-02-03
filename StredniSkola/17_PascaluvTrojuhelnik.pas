program PascaluvTrojuhelnik;
uses crt, math;

var i, j, k, l, vyska, sirka: integer;
var stred:extended;
p:array[1..100, 1..100] of integer;

function hodnota (x,y:integer) :integer;
  begin
   if x<1 then hodnota:=0
   else if y<1 then hodnota:=0
   else if x>sirka then hodnota:=0
   else if y>vyska then hodnota:=0
   else hodnota:=p[x,y];
  end;

begin
clrscr;

write('Zadejte v��ku troj�heln�ku (2-13): ');
readln(vyska);

sirka := ((vyska-1)*2)+1;

(* P�iprav� pole *)
for i:=1 to vyska do
  begin
    for j:=1 to sirka do
      p[i, j]:=0;
  end;
(* Nachyst� jedni�ku uprost�ed prvn�ho ��dku *)
p[vyska, 1]:=1;

(* Spo��t� tro�heln�k po ��dc�ch *)
for i:=2 to vyska do
  begin
    for j:=1 to sirka do
      begin
        p[j,i]:=hodnota(j-1, i-1) + hodnota (j+1, i-1);
      end;
  end;

(* Vyp��e troj�heln�k *)
clrscr;
for i:=1 to vyska do
  begin
    for j:=1 to sirka do
      begin
        if p[j,i]<>0 then
          begin
            gotoxy(j*3, i);
            write(p[j,i]);
          end;
      end;
    delay(500);
  end;


readkey;
end.
