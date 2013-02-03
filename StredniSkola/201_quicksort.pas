program quicksort;
  uses crt;

const max   = 79;//79
      vyska = 54;

  type Tcisla = record
    velikost  : integer;
    pivot     : boolean;
  end;
  
  var
    cisla : array[0..max] of Tcisla;
    Pcisla : integer;
    i, piv : integer;
    pocitadlo : integer; 

procedure sloupec(pozice,velikost:integer; pivot : boolean);
  var i:integer;
  begin
    for i:=1 to vyska do
      begin
        gotoxy(pozice*2, i);
        
        if pivot then
          textColor(3)
        else 
          textColor(2);
        
        if i>=vyska-velikost then
          write('°')
        else
          write(' ');
      end;
  end;

procedure vypis(pole: array of Tcisla; l,r : integer);
  var i:integer;
  begin
    for i:=l to r do
      sloupec(i, pole[i].velikost, pole[i].pivot);  
  end;
  
procedure vypisCisla(pole: array of Tcisla; l,r : integer);
  var i:integer;
  begin
    pocitadlo := pocitadlo +1;
    for i:= //1 to max do
            l to r do
      begin
        gotoxy(pocitadlo*3-2, i);
        if pole[i].pivot then
          textColor(3)
        else 
          textColor(2);
        
        write(pole[i].velikost);
      end;
        
  end;

function pivot(pole: array of Tcisla; l,r:integer): integer;
  var
    i,j,s,p,ind,roz : integer;
  begin
    s := 0;
    for i:=l to r do
      s := s + pole[i].velikost;
    p := round(s / (r-l));
    
    ind := 0;
    roz := 0;
    for i:=l to r do
      if (ind=0) or (abs(pole[i].velikost - p)<roz) then
        begin
          ind := i;
          roz := abs(pole[i].velikost - p);
        end;
    pivot := ind;                
  end;

procedure quicksort(var pole: array of Tcisla; l,r:integer);
  var
    polePom : array[0..max] of Tcisla;
    zleva, zprava : integer;
    i,j:integer;
    pom : Tcisla;
    konec : boolean;  
  begin
 
    piv := pivot(pole, l, r);
    cisla[piv].pivot := true;
    {sloupec(piv, pole[piv].velikost, true);}
    
    for i:=l to r do
      polePom[i] := pole[i];

    zleva := l;
    zprava:= r;      
    for i:=l to r do
      begin
           if polePom[i].velikost < polePom[piv].velikost then
        begin
          pole[zleva]:=polePom[i];
          zleva := zleva+1;
        end
      else if polePom[i].velikost > polePom[piv].velikost then
        begin
          pole[zprava]:=polePom[i];
          zprava := zprava-1;
        end;
      end;
    for i:=l to r do
      if polePom[i].velikost = polePom[piv].velikost then
        begin
          pole[zleva]:=polePom[i];
          zleva := zleva+1;
        end;
    piv := zleva-1;
    
    {vypisCisla(pole, l, r);
    delay(1000);
    }
    vypis(pole, l, r);
    
    if (piv-1)-l>0 then quicksort(pole, l, piv-1);
    if r-(piv+1)>0 then quicksort(pole, piv+1, r);
    
  end;
  
begin
  randomize;
  pocitadlo := 0;
  
  for i:=1 to max do 
    cisla[i].velikost:=random(vyska);
  Pcisla := max;

  {vypisCisla(cisla, 1, Pcisla);
   }

  quicksort(cisla, 1, Pcisla);

  readln;
  
  vypis(cisla, 1, Pcisla);
  
  readln;

end.