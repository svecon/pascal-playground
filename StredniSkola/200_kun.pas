program kun;
  {$MODE DELPHI}
  uses crt, sysutils;

  const
    NX      = 16;
    NY      = 16;
    BAREVNE = true;
    REKURZE = false;
    UKAZUJ  = true;
    
    DELAYNEXT = 0;
    
    BUNKA   = 3;

  type sachovnice = array [1..NX, 1..NY] of integer;
  
  type souradnice = record
    x : integer;
    y : integer;
  end;

  var
    i,j:integer;
    sirka:integer;
    vyska:integer;
    sirkaBunky:integer;
    vyskaBunky:integer;
    offX : integer;
    offY : integer;
    
    sach : sachovnice;
    konec : boolean;
    slepeCesty : integer;
    PADD : boolean;
    
procedure mrizka();
  var
    i,j:integer;
begin   
  // vodorovne
  for j:=1 to NY+1 do
    begin
      for i:=1 to sirka do
        begin
          gotoxy(i, (vyskaBunky+1)*(j-1)+1);
          write('=');  
        end;
    end;
  // svisle
  for j:=1 to NX+1 do
    begin
      for i:=1 to vyska do
        begin
          gotoxy((sirkaBunky+1)*(j-1)+1, i);  
          write ('|');  
        end;
    end;
end;

procedure zapis(skok, x, y :integer);
  var barva : integer;
  begin
    barva := round(skok/(NX*NY)*7);
    textBackground(barva);
    if barva = 7 then textColor(0)
    else textColor(7);
  
  if (PADD) OR (BAREVNE) then
    begin
    gotoxy(x*(sirkaBunky+1)-offX-1, y*(vyskaBunky+1)-offY-1);
    write('     ');
    gotoxy(x*(sirkaBunky+1)-offX-1, y*(vyskaBunky+1)-offY+1);
    write('     ');
    gotoxy(x*(sirkaBunky+1)-offX-1, y*(vyskaBunky+1)-offY);
    write(' ');
    gotoxy(x*(sirkaBunky+1)-offX+BUNKA, y*(vyskaBunky+1)-offY);
    write(' ');
  end; 

    gotoxy(x*(sirkaBunky+1)-offX, y*(vyskaBunky+1)-offY);
         if (skok >  0) and (skok < 10 ) then write(skok, '  ')
    else if (skok >=10) and (skok < 100) then write(skok, ' ')
    else if (skok > 0 ) then write(skok)
    else if (skok = 0 ) then write('   ');  
  end;

procedure vypis(pole: sachovnice);
  var
    i,j:integer;
  begin
    for i:=1 to NX do
      for j:=1 to NY do
        zapis(pole[i, j], i, j);
  end;
  
procedure vypisChytre(pole: sachovnice; wait : integer = 0; rewrite : boolean = false);
  var
    i,j,k,c : integer;
  begin
    if rewrite then
      begin
        textBackground(0);
        textColor(7);
        clrscr();
        mrizka();
    end;

    for k:=1 to NX*NY do
      for i:=1 to NX do
        for j:=1 to NY do
          if pole[i,j] = k then
            begin
              zapis(k, i, j);
              delay(wait);
            end;
  end;

function curPozice(pole: sachovnice; var max : integer):souradnice;
  var
    maxPoz : souradnice;
  begin
    max := 0;
    for i:=1 to NX do
      for j:=1 to NY do
        if max<pole[i,j] then
          begin
            max := pole[i,j];
            maxPoz.x := i;
            maxPoz.y := j;
          end;
    curPozice := maxPoz;
  end;

procedure najdiMoznosti(pole: sachovnice; pozice:souradnice; var Amoznosti : array of souradnice; var Pmoznosti : integer; hloubka:boolean = false);
  var
    i,j,x : integer;
    moznosti : array[0..9] of souradnice;
    hodnoty : array[0..9] of integer;
    
    xAmoznosti : array[0..9] of souradnice;
    xPmoznosti : integer;
    xSour : souradnice;
  begin
    moznosti[0].x := -2;
    moznosti[0].y := -1;
    
    moznosti[1].x := -1;
    moznosti[1].y := -2;
    
    moznosti[2].x := +1;
    moznosti[2].y := -2;
  
    moznosti[3].x := +2;
    moznosti[3].y := -1;
    
    moznosti[4].x := +2;
    moznosti[4].y := +1;
    
    moznosti[5].x := +1;
    moznosti[5].y := +2;
    
    moznosti[6].x := -1;
    moznosti[6].y := +2;
    
    moznosti[7].x := -2;
    moznosti[7].y := +1;
    
    Pmoznosti := 0;
    for i:=0 to 7 do
      begin
        if
          (pozice.x + moznosti[i].x <= NX) AND
          (pozice.x + moznosti[i].x >= 1)  AND
          (pozice.y + moznosti[i].y <= NY) AND
          (pozice.y + moznosti[i].y >= 1)  AND
          (pole[pozice.x + moznosti[i].x, pozice.y + moznosti[i].y] = 0) then
            begin
              Amoznosti[Pmoznosti].x := pozice.x + moznosti[i].x;
              Amoznosti[Pmoznosti].y := pozice.y + moznosti[i].y;
              
              if (REKURZE=false) and (hloubka=false) then
                begin
                  najdiMoznosti(pole, Amoznosti[Pmoznosti], xAmoznosti, xPmoznosti, true);
                  hodnoty[Pmoznosti] := xPmoznosti;
                end;
                               
              Pmoznosti := Pmoznosti +1;              
            end;
      end;
      
  if (REKURZE=false) and (hloubka=false) and (Pmoznosti>1) then
    begin
    for i:=0 to Pmoznosti-2 do
      for j:=0 to Pmoznosti-2 do
        if hodnoty[j]>hodnoty[j+1] then
          begin
            x := hodnoty[j];
            hodnoty[j] := hodnoty[j+1];
            hodnoty[j+1] := x;
                      
            xSour := Amoznosti[j];
            Amoznosti[j] := Amoznosti[j+1];
            Amoznosti[j+1] := xSour;
          end;
    end;     
  end;
  
function overit(pole: sachovnice):boolean;
  var
    i,j,k : integer;
    poz : souradnice;
    Amoznosti : array[0..9] of souradnice;
    Pmoznosti : integer;
    ukoncit : boolean;
  begin
    ukoncit := false;
    for i:=1 to NX do
      for j:=1 to NY do
        if pole[i,j] = 0 then
          begin
            poz.x := i;
            poz.y := j;
            
            najdiMoznosti(pole, poz, Amoznosti, Pmoznosti);
           
            if Pmoznosti = 0 then ukoncit := true;                        
          end;
    overit := ukoncit;  
  end;

function poskac(pole: sachovnice):boolean;
  var
    Amoznosti : array[0..9] of souradnice;
    Pmoznosti : integer;
    pozice : souradnice;
    max : integer;
    i : integer;
    polePomocne : sachovnice;
  begin
    
    
    pozice := curPozice(pole, max);
    if max>NX*NY then konec := true;
    

    
    najdiMoznosti(pole, pozice, Amoznosti, Pmoznosti);
    if Pmoznosti=0 then
      begin
        //slepeCesty := slepeCesty +1;
        //gotoxy(1, vyska+3);
        //write('Pocet slepych cest: ', slepeCesty);
      end;
    
    if REKURZE=true then
      vypis(pole);
    
    if max >= (NX*NY) then 
      begin
        if REKURZE=false then
          if UKAZUJ then
            vypisChytre(pole, DELAYNEXT)
          else
            vypis(pole);
        
        {vypis(pole);}
        readln;
        //delay(1000);
      end;
    {
    vypis(pole);
     
    delay(200);  
    }

    {
    if overit(pole) then
      begin
        poskac := false;
        konec := true;
      end;
    }

    if konec<>true then
    for i:=0 to Pmoznosti-1 do
      begin
        polePomocne := pole;
        polePomocne[Amoznosti[i].x, Amoznosti[i].y] := max+1;
        konec := poskac(polePomocne);
      end;
    poskac := false;
  end;

begin
  { === SETUP MRIZKA === }
  if NY > 8 then PADD := false
  else PADD := true;
  
  if PADD then
    begin
      offX := 3;
      offY := 1;
      sirkaBunky := BUNKA+2;
      vyskaBunky := 1+2;
    end
  else
    begin
      offX := 2;
      offY := 0;
      sirkaBunky := BUNKA;
      vyskaBunky := 1;    
    end;
  sirka := ((sirkaBunky+1)*NX)+1;
  vyska := ((vyskaBunky+1)*NY)+1;
  
  { === MRIZKA === }
  mrizka();
  
  { === SETUP KUN === }

  for i:=1 to NX do
    for j:=1 to NY do
      sach[i, j] := 0;    

  { === X === }
  konec := false;
  slepeCesty := 0;
  sach[1, 1] := 1;
  poskac(sach);

  readkey();
end.