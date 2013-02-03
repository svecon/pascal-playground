program Abeceda;
uses crt;

type abecedaRozsah = 'A'..'Z';
var abecedaPole : array[0..30] of abecedaRozsah;

procedure vytvoritAbecedu;
  var 
    i : integer;
    A,Z : integer;
  begin
    A := ord('A');
    Z := ord('Z');
    for i:=A to Z do
      begin
        abecedaPole[i-A]:=Chr(i);
      end;
    writeln(Z-A);    
  end;

begin

vytvoritAbecedu();
writeln(abecedaPole[0]);
readln;

end.