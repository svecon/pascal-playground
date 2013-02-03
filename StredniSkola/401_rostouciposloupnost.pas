program rostouciposloupnost;
  {$MODE DELPHI}
  uses crt, sysutils;

  type rada = record
    d : integer; {delka}
    k : integer; {pocet kazicu}
    x : integer; {pozice start}
    y : integer; {pozice konec}
    a : boolean; {jeste aktivni?}
  end;

  var
  {queue}
  a       : array [0..99] of integer;
  kbol    : array [0..99] of boolean;
  delka   : integer;
  {increasing queues}
  rady    : array [0..99] of rada;
  ri      : integer; {index aktualni rady}
  neji    : integer; {index nejdelsi rady}
  nejd    : integer; {velikost nejdelsi rady}
  {counters}
  i, j    : integer;
  {user input}
  k       : integer; {pocet kazicu} 

function jeKazic(x, y : integer):boolean;
  begin
    if kbol[x] then
      begin
        jeKazic := jeKazic(x-1, y);
      end
    else 
      if a[x] >= a[y] then
        begin
          jeKazic := true;
          kbol[y] := true;
        end
      else
        begin 
          jeKazic := false;
          kbol[y] := false;
        end;
  end;
  
procedure novaRada(x : integer);
  begin
    ri := ri + 1; 
    rady[ri].x := x;
    rady[ri].d := 0;
    rady[ri].k := 0;
    rady[ri].a := true;  
  end;

procedure vypisRadu(x : integer);
  var j : integer;
  begin
    for j:=rady[x].x to rady[x].y do
      if kbol[j] = false then write(a[j], ', ');  
  end;
  
begin
{delka generovane rady}
  delka := 20;
{generovani rady}
  for i:=0 to delka-1 do
    a[i] := i + 1;
  a[3] := 2;
  a[7] := 6;
  a[8] := 7;
  a[15] := 14;
  a[18] := 15;

write('Rada: ');  
  for i:=0 to delka-1 do
    write(a[i], ', ');
writeln;
  
{vypsat generovanou radu}
    
{najiti kazicu}  
  for i:=0 to delka-1 do
    if (a[i]>=a[i+1]) or (a[i-1]>=a[i+1]) then
      begin
        jeKazic(i, i+1);
      end; 
{vypis kazicu}      
  write('Kazici: ');   
  for i:=0 to delka-1 do
  if kbol[i] then
    begin
      write(a[i], ', ');
    end; 
  writeln;
  
{user input k = pocet kazicu}
  writeln;
  write('Vlozte "k": ');
  readln(k);
  
{hledani rad}
  ri := -1;
  novaRada(0);    
  for i:=0 to delka-1 do
    if kbol[i] then
      begin
        for j:=0 to ri do
          if rady[j].a then
          begin
            rady[j].k := rady[j].k + 1;
            if rady[j].k > k then begin rady[j].a := false; end;
            
          end;
        novaRada(i+1);
      end
    else 
      begin
        for j:=0 to ri do
          if rady[j].a then
          begin
            rady[j].d := rady[j].d + 1;
            rady[j].y := i; 
          end;
      end;
    

{Vypise vsechny rady}
writeln('Pocet rad: ', ri+1);
writeln;
  for i:=0 to ri do
    begin
      write(i+1, '.rada (', rady[i].d, '): ');
      vypisRadu(i);
      writeln;
    end;

{nejdelsi rada}
  nejd := 0;
  for i:=0 to ri do
    if rady[i].d > nejd then
      begin
        nejd := rady[i].d;
        neji := i;
      end;
  writeln;
  write('Nejdelsi rada (', rady[neji].d,'): ');
  vypisRadu(neji);


  readkey;
end.