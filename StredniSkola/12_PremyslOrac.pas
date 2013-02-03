program PremyslOrac;
uses crt;

var i,j,x,y,a,b,akce:integer;

volne:array[-1..100, -1..100] of boolean;

begin

clrscr;

writeln('Zadejte velikost pole (max 20*25): ');
read(a, b);


for i:=-1 to a do
  begin
    for j:=-1 to b do
      begin
        if (j<=0) or (i<=0) then volne[i,j]:=false
        else volne[i,j]:=true
      end;
  end;


clrscr;
i:=0; akce:=1; x:=1; y:=1;
while i<a*b do
begin
  i:=i+1;
  gotoxy(x*4-3,y); write(i); delay(50); volne[x,y]:=false;
  case akce of
    1:
      begin
        if volne[x,y+1] then y:=y+1
        else
          begin
            x:=x+1;
            akce:=2;
          end;
      end;
    2:
      begin
        if volne[x+1,y] then x:=x+1
        else
          begin
            y:=y-1;
            akce:=3;
          end;
      end;
    3:
      begin
        if volne[x,y-1] then y:=y-1
        else
          begin
            x:=x-1;
            akce:=4;
          end;
      end;
    4:
      begin
        if volne[x-1,y] then x:=x-1
        else
          begin
            y:=y+1;
            akce:=1;
          end;
      end;
  end;

end;


readkey;
end.
