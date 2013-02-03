Program pn_05_nejmensi_spolecny_nasobek;

var zk:array[1..5] of integer = (2, 2, 3, 6, 9);

function NSN(a:array of integer; count:integer):longint;
  var p:array of array of integer;
  var sub : array of integer;
  var i,pocetNasobku : integer;
  begin
    NSN := 0;
    pocetNasobku := 1;
    setLength(p, pocetNasobku);    
    setLength(sub, count+1);
    
    for i:= low(a) to high(a) do
      sub[i] := a[i];
      
    p[0] := sub;     
  end;

begin

  write(NSN(zk, 5));
  readln;

end.