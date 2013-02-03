program nasobenimatic;
  {$MODE DELPHI}
  uses crt, sysutils, classes;
  
  const maxSize = 99;

  type matice = record
    a       : array[1..maxSize, 1..maxSize] of integer;
    x, y    : integer;
  end;

  var
  a, b, c         : matice;

procedure vytvorMatici(var matice: matice; x:integer = -1; y:integer = -1);
  var
    i,j     : integer;
begin
  matice.x := x;
  matice.y := y;
  
  if(x = -1) then
    begin
      write('Jak je matice siroka? ');
      readln(matice.x);
    end;
  if(y = -1) then
    begin
      write('Jak je matice vysoka? ');
      readln(matice.y);
    end;
  
  for i:=1 to matice.y do
    for j:=1 to matice.x do
      begin
      matice.a[i][j] := 0;
      end;
end;

procedure vypisMatici(var matice: matice);
  var
    i,j     : integer;
begin
  for i:=1 to matice.y do
    begin
      for j:=1 to matice.x do
        write(matice.a[i][j], ' ');
      writeln;
    end;
end;

procedure nactiRadek(var matice: matice; radek: integer);
  var
    str     : TStringList;
    s       : string;
    i       : integer;
begin
  readln(s);
  if length(s)=matice.x then
    begin
      for i:=1 to length(s) do
        matice.a[radek][i] := strtoint(s[i]);
    end
  else
    begin
      str := TStringList.Create;
      str.Delimiter := ',';
      str.DelimitedText := s;
      for i:=0 to str.count-1 do
        matice.a[radek][i+1] := strtoint(str[i]);  
    end;
end;

procedure nactiMatici(var matice: matice);
  var
    i       : integer;
begin
  for i:=1 to matice.y do
    begin
      write(i, '-ty radek matice: ');
      nactiRadek(matice, i);
    end;
end;

procedure vynasobMatice(var a, b, c : matice);
  var
    i,j,k,sum : integer;
begin
  for i:=1 to c.y do
    for j:=1 to c.x do
      begin
        sum := 0;
        for k:=1 to a.x do
          sum := sum + (a.a[i][k] * b.a[k][j]);
        c.a[i][j] := sum;
      end;
end;
  
begin
  writeln('=== Vytvorte 1. matici ===');
  vytvorMatici(a);
  nactiMatici(a);
  vypisMatici(a);
  
  writeln('=== Vytvorte 2. matici ===');
  vytvorMatici(b);
  if a.x <> b.y then
    begin
      writeln('Tyto matice nelze nasobit. Pocet sloupcu prvni matice musi byt stejny jako pocet radku druhe.');
      readkey;
      exit;
    end;
  nactiMatici(b);
  vypisMatici(b);
  
  vytvorMatici(c, a.y, b.x);
  writeln('Matice vznikla soucinem 1. * 2.');
  
  vynasobMatice(a,b,c);
  vypisMatici(c);
  
  readkey;
end.