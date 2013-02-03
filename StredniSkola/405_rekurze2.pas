program prirozenacisla;
  {$MODE DELPHI}
  uses crt, sysutils, classes;

  var
  s     : array[0..15] of string[1];
  n, z  : integer;
  i : integer;

procedure prevadej(n, z: integer);
begin
  if n >= z then
    begin
      prevadej(n div z, z);
    end;
  write(s[n mod z]);
end;
  
begin

  for i:=0 to 9 do s[i]:=inttostr(i);
  s[10] := 'A';
  s[11] := 'B';
  s[12] := 'C';
  s[13] := 'D';
  s[14] := 'E';
  s[15] := 'F';
  
  write('Zadej zaklad: ');
  readln(z);
  
  write('Zadej cislo v desitkove soustave: ');
  readln(n);
  
  prevadej(n, z);


  readkey;  
end.