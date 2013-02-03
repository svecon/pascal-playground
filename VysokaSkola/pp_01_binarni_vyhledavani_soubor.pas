Program pp_01_binarni_vyhledavani_soubor;

var cisla: array of longint;
var fData,fDotazy,fVysledek: text;
var N,k,i,dotaz:longint;

function hledej(var x:longint; l,r : longint):longint;
  var stred : longint;
  begin
    if (l>r) then hledej := 0
    else
      begin
        stred := (l + r) div 2;
        
        if cisla[stred] > x then
          hledej := hledej(x, l, stred-1)
        else if cisla[stred] < x then
          hledej := hledej(x, stred+1, r)
        else // s[stred] == x
          begin
            while cisla[stred-1] = x do
              stred := stred-1;
            hledej := stred;
          end;
      end;
  end;


begin
  assign(fData, 'pp_01_data.in');
  reset(fData);
  assign(fDotazy, 'pp_01_dotazy.in');
  reset(fDotazy);
  assign(fVysledek, 'pp_01_vysledky.out');
  rewrite(fVysledek);
  
  read(fData, N);
  setLength(cisla, N+5);
  for i:=1 to N do
    read(fData, cisla[i]);
  
  read(fDotazy, k);
  for i:=1 to k do
    begin
      read(fDotazy, dotaz);
      write(fVysledek, hledej(dotaz, 1, N), ' ');
    end;
  
  close(fDotazy);
  close(fData);
  close(fVysledek);
    
end.
