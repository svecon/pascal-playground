program magickyCtverec;
uses crt;

var i,j,x,y,l,k,n:integer;
var o,p,soucet:extended;
volno:array[1..100,1..100] of boolean;

function sprav(x:integer) :integer;
  begin
    if x>n then x:=1
    else if x<1 then x:=n;
    sprav:=x;
  end;

begin
clrscr;

write('Zadejte velikost magického ctverce (1-9): ');
read(n);
if n mod 2 = 0 then n:=n+1;
{if n>10 then n:=9
else if n<1 then n:=1;}

for i:=1 to n+1 do
  begin
    for j:=1 to n+1 do volno[i,j]:=true;
  end;

clrscr;

soucet:=((n*n*n)+n)/2;
writeln('Sou¼et ka§d‚ho ý dku, sloupce, ¼i diagon ly je: ', soucet:4:2);

x:=n;
p:=(n+1)/2;
y:=round(p);

for i:=1 to n*n do
  begin
    gotoxy(x*4, y*2+2);
    {delay(100);}
    volno[x,y]:=false;
    write(i);

    if volno[sprav(x+1),sprav(y+1)] then
      begin
        x:=sprav(x+1);
        y:=sprav(y+1);
      end
    else x:=sprav(x-1);

  end;


readkey;
end.
