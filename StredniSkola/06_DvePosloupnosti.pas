program dvePosloupnosti;
uses crt;

var i,j,n,m,k,l:integer;
var bool:boolean;
a:array[1..100] of integer;
b:array[1..100] of integer;

prunik:array[1..100] of integer;
sjednoceni:array[1..100] of integer;

var nejvetsi,druhenej:integer;

begin

clrscr;

(* Na��t�n� prvn� posloupnosti *)
write('Zadejte po�et prvk� prvn�ho pole: ');
readln(n);

for i:=1 to n do
  begin
    write(i, '-t� prvek: ');
    read(a[i]);
  end;

(* Na��t�n� druh� posloupnosti *)
write('Zadejte po�et prvk� druh�ho pole: ');
readln(m);
for i:=1 to m do
  begin
    write(i, '-t� prvek: ');
    read(b[i]);
  end;

(* Za��tek vlastn�ho programu *)

writeln();
writeln('======================');

(* => Vyskytuj� se v prvni posloupnosti dva stejne prvky? *)
for i:=1 to n do
  begin
    for j:=1 to n do
      begin
        if (a[i]=a[j]) and (i<>j) then writeln('Nalezen stejn� prvek: ', a[i]);
      end;
  end;

(* => Pr�nik a sjednocen� obou posloupnost� *)

(* => Druh� nejv�t� ��slo v druh� posloupnosti *)

for i:=1 to m do
  begin
    if (i=1) or (nejvetsi<b[i]) then nejvetsi:=b[i];
  end;
for i:=1 to m do
  begin
    if (i=1) or ((druhenej<b[i]) and (b[i]<nejvetsi)) then druhenej:=b[i];
  end;
writeln('Nejv�t� ��slo druh� �ady: ', nejvetsi);
writeln('Druh� nejv�t� ��slo druh� �ady: ', druhenej);

writeln('======================');

(* => Se�azen� prvn� mno�iny bublinovou metodou *)
for i:=1 to n-1 do
  for j:=1 to n-1 do
    if a[j]>a[j+1] then
      begin
        k:=a[j];
        a[j]:=a[j+1];
        a[j+1]:=k;
      end;

writeln('Se�azen� prvn� mno�iny bublinovou metodou:');
for i:=1 to n do write(a[i], ', ');
writeln('=====================');

(* => Se�azen� druh� mno�iny hled�n�m minima *)

(* => Prvky prvn� mno�iny, kter� nejsou ve druh� *)
writeln('Prvky z prvn� mno�iny, kter� nejsou ve druh�:');
for i:=1 to n do
  begin
  bool:=true;
    for j:=1 to m do
      begin
        if a[i]=b[j] then bool:=false;
      end;
    if bool then write(a[i], ', ');
  end;


  (*
for i:=1 to n do
  begin
    j:=0;
    repeat
     begin
       j:=j+1;
       if a[i]=b[j] then
         begin
           writeln('Shoda: ', a[i]);
           j:=m;
         end;
     end;
    until j=m;
  end;
*)

readkey;
end.
