program Damy;
  {$MODE DELPHI}
  uses crt, sysutils;

  const
    SIZE    = 8;
    UKAZUJ  = true;
    BUNKA   = 3;
    
  type sachovnice = array [1..SIZE, 1..SIZE] of integer;
  
  type souradnice = record
    x : integer;
    y : integer;
  end;

  var
    offX, offY : integer;
    sirkaBunky, vyskaBunky : integer;
    sirka, vyska : integer;
    
  var
    x:array[1..8] of 1..8;
    volnarada:array[1..8] of boolean;
    volnadiag1:array[2..16] of boolean;
    volnadiag2:array[-7..7] of boolean;
    i,k:integer;

procedure mrizka();
  var
    i,j:integer;
  begin   
    // vodorovne
    for j:=1 to SIZE+1 do
      begin
        for i:=1 to sirka do
          begin
            gotoxy(i, (vyskaBunky+1)*(j-1)+1);
            write('=');  
          end;
      end;
    // svisle
    for j:=1 to SIZE+1 do
      begin
        for i:=1 to vyska do
          begin
            gotoxy((sirkaBunky+1)*(j-1)+1, i);  
            write ('|');  
          end;
      end;
  end;

procedure zapis(skok, x, y :integer; smazat:boolean=false);
  var barva : integer;
  begin
   
    if smazat then barva := 0
    else barva := 12;
    
    textBackground(barva);
    if barva = 7 then textColor(0)
    else textColor(7);
  
    gotoxy(x*(sirkaBunky+1)-offX-1, y*(vyskaBunky+1)-offY-1);
    write('     ');
    gotoxy(x*(sirkaBunky+1)-offX-1, y*(vyskaBunky+1)-offY+1);
    write('     ');
    gotoxy(x*(sirkaBunky+1)-offX-1, y*(vyskaBunky+1)-offY);
    write(' ');
    gotoxy(x*(sirkaBunky+1)-offX+BUNKA, y*(vyskaBunky+1)-offY);
    write(' '); 

    gotoxy(x*(sirkaBunky+1)-offX, y*(vyskaBunky+1)-offY);
         if  smazat then write('   ')
    else if (skok >  0) and (skok < 10 ) then write(skok, '  ')
    else if (skok >=10) and (skok < 100) then write(skok, ' ')
    else if (skok > 0 ) then write(skok)
    else if (skok = 0 ) then write('   ');  
  end;
    
procedure projdi(i:integer);
  var
    j:integer;
  
  procedure vypis;
    var
      n:integer;
    begin
      for n:=1 to 8 do write(x[n], ' '); writeln;
      k:=k+1;
      if k=12 then
        begin
          writeln('Stisknete Enter');
          readln;
          clrscr;
          k:=0; 
        end;
    end;
    
  procedure nakresli(i:integer; smazat:boolean=false);
    var
      q,w:integer;
    begin
      for q:=1 to i do
        begin
          zapis(q, q, x[q], smazat);
          if smazat=false then delay(1);
        end;  
    end;
    
  begin
    j:=1;
    while j<=8 do
      begin
        if volnarada[j] and volnadiag1[i+j] and volnadiag2[i-j] then
          begin
            x[i] := j;
            volnarada[j] := false;
            volnadiag1[i+j] := false;
            volnadiag2[i-j] := false;
            nakresli(i);
            if i<8 then projdi(i+1)
            else readln;
            volnarada[j] := true;
            volnadiag1[i+j] := true;
            volnadiag2[i-j] := true;
            nakresli(i, true);
          end;
        j:=j+1;
      end;
  end;

begin
  { === SETUP MRIZKA === }
  offX := 3;
  offY := 1;
  sirkaBunky := BUNKA+2;
  vyskaBunky := 1+2;
  sirka := ((sirkaBunky+1)*SIZE)+1;
  vyska := ((vyskaBunky+1)*SIZE)+1;
  mrizka();
  
  { === SETUP HLAVNÍ PROGRAM ===}
  k:=0;
  for i:=1 to 8 do volnarada[i] := true;
  for i:=2 to 16 do volnadiag1[i] := true;
  for i:=-7 to 7 do volnadiag2[i] := true;
  
  projdi(1);
    
  readkey;
end.