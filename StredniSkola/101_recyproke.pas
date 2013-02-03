program Recyproke;
uses crt;

var maxMocnina       : integer;
var i : integer;
var koeficienty     : array[0..10, 0..50] of double;
var aktualni : integer;

var del: array[0..100] of double;
var pocetDel: integer;
var koreny: array[0..100] of double;
var pocetKoreny: integer;
var boolPomocna : boolean;

function umocni(x:double; y:integer):extended; {x^y}
  var i:integer;
  begin
    if y=0 then umocni:=1
    else if y>0 then umocni := x;
    
    if y>1 then
      begin
        for i:=1 to y-1 do
          begin
            umocni := umocni * x;
          end;
      end;
  end;

procedure delitele(delenec : integer; var del: array of double; var pocetDel:integer);
  var i:integer;
  begin
    pocetDel:=0;
    if delenec<0 then delenec := delenec * (-1);
    
    for i:=1 to delenec do
      begin
        if delenec mod i = 0 then
          begin
            del[pocetDel] := i;
            pocetDel := pocetDel+1;
            del[pocetDel] := i*(-1);
            pocetDel := pocetDel+1;
          end;
      end;
    
  end;

function dosadit(koren:double; koeficienty: array of double; maxMocnina:integer):boolean;
  var sum:double;
  var i: integer;

  begin
    dosadit := false;
    sum:=0;

    for i:=maxMocnina downto 0 do
      sum := sum + (koeficienty[i] * umocni(koren, i));

    //writeln('Dosazuju: ', koren:2:2);
    //writeln('Suma: ', sum:2:2);
    //writeln;
    
    if sum=0 then dosadit := true;
  end;

procedure napsatRovnici();
  var i:integer;
  begin
    writeln;
    for i:=maxMocnina downto 0 do
      begin
        if koeficienty[aktualni, i]<0 then write(koeficienty[aktualni, i]:0:1, 'x^', i, ' ')
        else if i=maxMocnina then write(koeficienty[aktualni, i]:0:1, 'x^', i, ' ')
        else if i=0 then write('+ ', koeficienty[aktualni, i]:0:1)
        else write('+ ', koeficienty[aktualni, i]:0:1, 'x^', i, ' ')         
      end;  
  end;

procedure hlavni();
  begin

  { DELITELE }
  delitele( round(koeficienty[aktualni, 0]), del, pocetDel);

  { KORENY }
  pocetKoreny := 0;
  for i:=0 to pocetDel-1 do
    begin
      boolPomocna := dosadit(del[i], koeficienty[aktualni], maxMocnina);
      if boolPomocna then
        begin
          koreny[pocetKoreny] := del[i];          
          pocetKoreny := pocetKoreny+1;  
        end;
    end;
  
  { HORNEROVO SCHEMA }
  if pocetKoreny>0 then
    begin
      writeln('Delim: ', koreny[0]:2:2);
      koeficienty[aktualni+1][maxMocnina] := 0;
      for i:= maxMocnina-1 downto 0 do
        begin
          koeficienty[aktualni+1][i]:=koreny[0]*koeficienty[aktualni+1][i+1] + koeficienty[aktualni][i+1];
        end;
      maxMocnina := maxMocnina -1;
      aktualni := aktualni+1;

      { vypsat novou rovnici }
      for i:=maxMocnina downto 0 do
        begin
          write(koeficienty[aktualni][i]:2:0, 'x^', i, ', ');
          writeln;
        end;
    end;


  end;

begin

  aktualni := 1;

  { USER INPUT }
  write('Maximalni mocnina? ');
  readln(maxMocnina);
  
  for i:=maxMocnina downto 0 do
    begin
      write('x^', i, ': ');
      readln(koeficienty[aktualni, i]);  
    end;
  
  repeat
    hlavni;
  until (maxMocnina=0) or (pocetKoreny=0);
  
  napsatRovnici;
  


  readln;  
end.