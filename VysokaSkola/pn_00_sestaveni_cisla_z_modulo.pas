Program pn_00_sestaveni_cisla_z_modulo;

const pocet_prvocisel = 5;

type Tprvocislo = record
  prvocislo:integer;
  zbytek:integer;
end;

var zbytky : array[1..pocet_prvocisel] of integer = (0,0,0,0,0);
var prvocisla : array[1..pocet_prvocisel] of integer = (2,3,5,7,11);
var nasobky:array[1..pocet_prvocisel] of Tprvocislo;
var prvocislo : Tprvocislo;
var pricti:integer;
var i :integer;
var x :integer;

begin

  // inicializace
  for i:=1 to pocet_prvocisel do
    begin
      with prvocislo do begin
        prvocislo := prvocisla[i];
        zbytek := zbytky[i];      
      end;
      nasobky[i] := prvocislo;
    end; 

  //výpočet
  x := nasobky[1].prvocislo - nasobky[1].zbytek;
  i:=2;
  pricti := nasobky[1].prvocislo;
  
  while i<=pocet_prvocisel do
    begin
      if x mod nasobky[i].prvocislo = nasobky[i].zbytek then
        begin
          pricti := pricti * nasobky[i].prvocislo;
          i:=i+1;
        end
      else x:= x + pricti;    
    end;
  
  write(x);
  readln;  

end.