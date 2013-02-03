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

(* NaŸ¡t n¡ prvn¡ posloupnosti *)
write('Zadejte poŸet prvk… prvn¡ho pole: ');
readln(n);

for i:=1 to n do
  begin
    write(i, '-tì prvek: ');
    read(a[i]);
  end;

(* NaŸ¡t n¡ druh‚ posloupnosti *)
write('Zadejte poŸet prvk… druh‚ho pole: ');
readln(m);
for i:=1 to m do
  begin
    write(i, '-tì prvek: ');
    read(b[i]);
  end;

(* ZaŸ tek vlastn¡ho programu *)

writeln();
writeln('======================');

(* => Vyskytuj¡ se v prvni posloupnosti dva stejne prvky? *)
for i:=1 to n do
  begin
    for j:=1 to n do
      begin
        if (a[i]=a[j]) and (i<>j) then writeln('Nalezen stejnì prvek: ', a[i]);
      end;
  end;

(* => Pr…nik a sjednocen¡ obou posloupnost¡ *)

(* => Druh‚ nejvØtç¡ Ÿ¡slo v druh‚ posloupnosti *)

for i:=1 to m do
  begin
    if (i=1) or (nejvetsi<b[i]) then nejvetsi:=b[i];
  end;
for i:=1 to m do
  begin
    if (i=1) or ((druhenej<b[i]) and (b[i]<nejvetsi)) then druhenej:=b[i];
  end;
writeln('NejvØtç¡ Ÿ¡slo druh‚ ýady: ', nejvetsi);
writeln('Druh‚ nejvØtç¡ Ÿ¡slo druh‚ ýady: ', druhenej);

writeln('======================');

(* => Seýazen¡ prvn¡ mno§iny bublinovou metodou *)
for i:=1 to n-1 do
  for j:=1 to n-1 do
    if a[j]>a[j+1] then
      begin
        k:=a[j];
        a[j]:=a[j+1];
        a[j+1]:=k;
      end;

writeln('Seýazen¡ prvn¡ mno§iny bublinovou metodou:');
for i:=1 to n do write(a[i], ', ');
writeln('=====================');

(* => Seýazen¡ druh‚ mno§iny hled n¡m minima *)

(* => Prvky prvn¡ mno§iny, kter‚ nejsou ve druh‚ *)
writeln('Prvky z prvn¡ mno§iny, kter‚ nejsou ve druh‚:');
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
