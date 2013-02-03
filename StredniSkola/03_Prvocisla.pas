program Prvocisla;
uses crt;

var i,j,b,max,pocet: integer;
p:array[1..3500] of integer;
var bool:boolean;

begin

clrscr;

write('Kolik prvoü°sel pot˝ebujete? (1-3499): ');
readln(max);

if max > 3499 then max := 3499
else if max<1 then max := 1;

p[1]:= 2;
pocet:=1;
i:=1;

writeln('Prvoü°sla: ');
while pocet<=max do
  begin
    i:=i+2;
    bool:= true;
    j:=1;
    while (bool) and (p[j]<=sqrt(i)) do
      begin
        if i mod p[j] = 0 then
          begin
            bool:= false;
          end;
        j:=j+1;
      end;

    if (bool) and (i<>1) then
      begin
        pocet:=pocet+1;
        p[pocet]:=i;
        (*write(i:8, ', ');*)
      end;
  end;

for i:=1 to pocet-1 do
  begin
    writeln(p[i]);
  end;

(*
writeln();
writeln('Bylo nalezeno ', pocet, ' prvoü°sel!');
*)

readkey;
end.
