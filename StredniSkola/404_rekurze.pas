program prirozenacisla;
  {$MODE DELPHI}
  uses crt, sysutils, classes;

procedure prirozeneCislo(n:integer);
begin
  if n > 0 then
    begin
      write(n, ', ');
      prirozeneCislo(n-1);
    end;
end;
  
begin
  prirozeneCislo(10);
  readkey;
end.
  
