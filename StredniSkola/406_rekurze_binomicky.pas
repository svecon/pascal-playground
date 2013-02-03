program prirozenacisla;
  {$MODE DELPHI}
  uses crt, sysutils, classes;

  var
  n, k : integer;
  
function binomClen(n,k:integer):double;
begin
  if k > 0 then binomClen := n / k * binomClen(n-1, k-1)
  else binomClen := 1;
end;
  
begin

  write('Vloz n: ');
  readln(n);
  write('Vloz k: ');
  readln(k);
  
  writeln(binomClen(n,k):1:0);

  readkey;
end.