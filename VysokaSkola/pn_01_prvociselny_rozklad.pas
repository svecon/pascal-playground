Program pn_01_prvociselny_rozklad;

{
Napište program, který přečte ze vstupu celé číslo větší než 1
a vytiskne jeho rozklad na součin prvočinitelů, oddělených hvězdičkami,
v rostoucím pořadí, např. pro vstup 28 vytiskne výstup 28=2*2*7
}

  var x:integer; {rozkladane cislo}
  var a:array[0..99] of integer; {pole prvocisel}
  var p:integer; {pocet rozkladu}
  var i:integer; {counter}
  var y:integer;

procedure vypis(var a:array of integer; pocet:integer);
  var i:integer;
  begin
    for i:=0 to pocet do
      begin
        write(a[i]);
        if i<>pocet then
          write('*');          
      end;
  end;

begin
  read(x);
  y := x;
  
  i := 1;
  p := 0;
  while x > 1 do
    begin
      i:=i+1;
      
      if x mod i = 0 then
        begin
          x := x div i;
          a[p] := i;
          p := p+1;
          i:=1;
        end;      
    end;
    write(y, '=');
    vypis(a, p-1);
end.