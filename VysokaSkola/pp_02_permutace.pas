Program pp_02_byrokraticky_aparat_permutace;

  var N,i,p,j,x,y,prev,cc,Pnasobky,vysledek,otacky:longint;
  var pravidla,nasobky:array of longint;
  var prozkoumano:array of boolean;
  var Fpravidla:text;
  
  var prvocislaC: array[2..32768] of integer;
  var Pprvocisla: integer;
  var prvocisla: array[1..32768] of integer;
begin

  // inicializace proměnných
  assign(Fpravidla, 'pp_02_pravidla.in');
  reset(Fpravidla);

  read(Fpravidla, N);
  setLength(pravidla, N+1);
  setLength(nasobky, N+1);
  setLength(prozkoumano, N+1);
  
  // inicializace cest
  for i:=1 to N do
    begin
      nasobky[i] := 0;
      prozkoumano[i] := false;
      
      read(Fpravidla, x,y);
      pravidla[x] := y;
    end;

  // procházení cyklů (cest)
  Pnasobky := 0;
  otacky := 0;
  for i:=1 to N do
    begin
      j := i;
      while not prozkoumano[j] do
        begin
          otacky := otacky + 1;
          prozkoumano[j] := true;
          j := pravidla[j];
          
          if prozkoumano[j] then
            begin
              Pnasobky := Pnasobky +1;
              nasobky[Pnasobky] := otacky;
              otacky := 0;
            end;
        end;
    end;
  
    
  // počítání NSN
  
  for i:=2 to 32768 do
    prvocislaC[i] := 0;
  Pprvocisla := 0;
  
  for y:=1 to Pnasobky do
    begin
    
      write('/', nasobky[y]);
    
      i := 1;
      p := 0;
      x := nasobky[y];
      prev := 0;
      cc := 0;
      while x > 1 do
        begin
          i:=i+1;
          
          if x mod i = 0 then
            begin
              x := x div i;
              cc := cc + 1;
              
              if (prev<>i) and (p<>0) then
                begin
                  if prvocislaC[prev] = 0 then
                    begin
                      Pprvocisla := Pprvocisla + 1;
                      prvocisla[Pprvocisla] := prev;
                      prvocislaC[prev] := cc;
                    end
                  else if prvocislaC[prev]<cc then prvocislaC[prev] := cc;//prvocislaC[i] + 1;
                  //cc := 1;
                end;
                
              if (prev<>i) then cc := 1;
                
              p := p+1;
              i:=1;
              prev := i;
            end;
        end;
    
    end;
  
  writeln;
  for i:=1 to Pprvocisla do
    write('*', prvocislaC[prvocisla[i]]);
    
  writeln;
  for i:=1 to Pprvocisla do
    write('-', prvocisla[i]);
  
  vysledek := 1;  
  for i:=1 to Pprvocisla do
    for y:=1 to prvocislaC[prvocisla[i]] do 
      vysledek := vysledek * prvocisla[i];

  writeln;
  write(vysledek);
  readln;
      

end.