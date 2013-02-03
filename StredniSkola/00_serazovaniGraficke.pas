program serazovaniGraficke;
uses crt;

const max=74;
      vyska=49;
var i,j,pom,poz,pozV:integer;

type
  cisla = record
    barva:integer;
    velikost:integer;
  end;

var pomT:cisla;  
var pole: array[0..200] of cisla;

procedure sloupec(pozice,velikost,barva:integer);
  var i:integer;
  begin
    for i:=vyska-pozV to vyska do
      begin
        gotoxy(pozice*2, i);
        textColor(barva);
        if i>=49-velikost then write('°')
        else write(' ');
      end;
  end;

procedure vypis;
  var i:integer;
  begin
    for i:=1 to poz+1 do
      sloupec(i, pole[i].velikost, pole[i].barva);  
  end;

begin

randomize;

for i:=1 to max do 
  begin
    pole[i].velikost:=random(vyska);
    pole[i].barva:=round((pole[i].velikost / vyska) * 14)+1// random(15)+1;
  end;

poz:=max;
pozV:=vyska;
for i:=1 to max-1 do
begin
  vypis;
  gotoxy(2,2);
  write('Serazeno: ', i/(max-1)*100:1:1, '%');
  for j:=1 to poz-1 do
    if pole[j+1].velikost<pole[j].velikost then
      begin
        pozV:=pole[j].velikost;
        poz:=j;
        pomT := pole[j+1];
        pole[j+1] := pole[j];
        pole[j] := pomT;
      end;
end;

readln;
end.