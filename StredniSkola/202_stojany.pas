{
 od ústavy - charakteristika, vývoj
 pocátky demokracie, delení + volby
 státní moc - delba, státní orgány, výkoná moc, soudní moc, legislativní proces
 politické strany - levice, pravice - ideologie už ne
}
program stojany;
  uses crt;

  const
    Nmax        = 5;
    MEZERA      = 2;
    VYSKAPROG   = 50;
    SIRKAPROG   = 150;

  var
    vyskaVeze : integer;
    sirkaVeze : integer;

function sirkaKruhu(n: integer) : integer;
  begin
    sirkaKruhu := (n*2) +1;
  end;

procedure vykresliTalir(n: integer);
  var
    i : integer;
  begin
    textColor(random(15)+1);
  
    gotoxy(Nmax-n+1, 2*n);
    for i:=1 to 2*n+1 do
      write('=');
      
    textColor(15);        
  end;

procedure vykresliVez(a : integer);
  var
    tycX : integer;
    i : integer;
  begin
    tycX := a*sirkaVeze+2;
    
    window((a-1)*(MEZERA+sirkaVeze)+MEZERA, MEZERA, a*(MEZERA+sirkaVeze), MEZERA+vyskaVeze);
    
    for i:=1 to vyskaVeze do
      begin
        gotoxy(round((sirkaVeze-1)/2)+1, i);
        write('°');
      end;

      
    for i:=1 to Nmax do      
      vykresliTalir(i);
      
    window(1, 1, SIRKAPROG, VYSKAPROG);
    
  
  end;


  
begin
  { SETUP }
  randomize;

  vyskaVeze := 2*Nmax;
  sirkaVeze := sirkaKruhu(Nmax);
  
  vykresliVez(1);
  vykresliVez(2);
  vykresliVez(3);
  
  readln;
end.