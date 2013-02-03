program p03;

type Tauto = record
  vaha : longint;
  garaz : integer;
end;

type
  PSeznam = ^TSeznam;
  TSeznam = record
                 val: integer;
                 next: PSeznam
  end;

var N : integer; {parkovacích míst}
var M : integer; {pocet aut}
var garaz : array of integer;
var auto : array of Tauto;
var maxPouzito : integer;
var suma : longint;
var volne : PSeznam;
var mezera : integer;

var i,x : integer;

procedure pridejVolno( iAuto: integer);
var p: PSeznam;
begin
  new( p );
  p^.val := auto[iAuto].garaz;
  p^.next := volne;
  volne := p
end;

function najdiVolno() : integer;
var p, prev, minPrev, minP: PSeznam;
var min : integer;
begin
  if volne = nil then
    begin
      najdiVolno := -1;
      exit;
    end;
    
  prev := nil;
  min := MAXINT;
  p := volne;
  
  while (p <> nil) do
    begin
      if p^.val < min then
        begin
          minPrev := prev;
          minP := p;
          min := p^.val;
        end;
        
      prev := p;
      p := p^.next;
    end;
    
  if minP = volne then
    begin
      najdiVolno := min;
      volne := nil;
      dispose(minP);
    end
  else
    begin
      minPrev^.next := minP^.next;
      najdiVolno := min;
      dispose(minP);
    end;
end;

begin

  read(N, M);
  setLength(garaz, N+2);
  setLength(auto, M+2);
  
  for i:=1 to N do
    read (garaz[i]);
    
  for i:=1 to M do
    read (auto[i].vaha);
    
  maxPouzito := 0;
  suma := 0;
  volne := nil;
  for i:=1 to 2*M do
    begin
      read(x);
      
      if x > 0 then
        begin
          mezera := najdiVolno;
          if mezera = -1 then
            begin
              inc(maxPouzito);
              auto[x].garaz := maxPouzito;
              suma := suma + (garaz[maxPouzito]*auto[x].vaha);
            end
          else 
            begin
              auto[x].garaz := mezera;
              suma := suma + (garaz[mezera]*auto[x].vaha);
              {writeln('(', mezera, garaz[mezera], ', ', auto[x].vaha, ')');}              
            end;
        end
      else if x < 0 then
        begin
          pridejVolno(abs(x));
        
        end;
        
    {writeln('=', suma); }   
    
    
    end;
    
  write(suma);

end.