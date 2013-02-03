{
Na standardním vstupu je zadáno císlo N (1 = N = 40). Vypište na standardní výstup všechny možnosti, jak toto císlo rozložit na soucet celých kladných císel. Každý rozklad musí být uveden na samostatném rádku, scítanci vyjmenováni od nejmenšího k nejvetšímu a oddeleny znaménkem "+". Na poradí rádku nezáleží.

Napríklad pro N=5 je jeden ze správných výstupu následující:

1+1+1+1+1
1+1+1+2
1+1+3
1+2+2
1+4
2+3
5
}

program pn6_soucet;

const MAX = 41;
var a : array[0..MAX] of integer;
var i : integer;
var N : integer;
var mezera : boolean;
var poc : longint;

procedure printArr;
  var i : integer;
  begin
    inc(poc);
    if mezera then writeln;
    i := 1;
    while a[i]<>0 do
      inc(i);
    dec(i);
    
    while (i>=1) and (a[i]<>0) do
      begin
        write(a[i]);
        if (i-1>=1) and (a[i-1] <> 0) then write('+');
        dec(i);
      end;
    mezera := true;   
  end;

procedure rozloz(zbytek, hloubka : integer);
  var i : integer;
  var min : integer;
  begin
    if zbytek = 0 then printArr
    else
      begin
        if zbytek > a[hloubka-1] then min := a[hloubka-1] else min := zbytek;
        for i := min downto 1 do
          begin
            a[hloubka] := i;
            rozloz(zbytek - i, hloubka + 1);
          end;
        a[hloubka] := 0;
      end; 
  end;

begin
  mezera := false;
  poc := 0;

  a[0] := MAX+1;
  for i:=1 to MAX do
    a[i] := 0;
    
  read(N);
  
  rozloz(N, 1);
  
  write(poc);

end.