program vyrazovani_rychle;

const MaxPocetHracu = 10;
const MaxPocetKol = 5;
const Odmena = 1000;

type Tobsah = record
  vyhra : longint;
  vyrazeno,celkem : integer;
end;

var a : array[1..MaxPocetHracu, 1..MaxPocetKol] of longint;//Tobsah;
var i,n,v,k,j : integer;
var kola : integer;
var max,argmax,body : longint;

function Vyhra(vyrazeno, hraci : integer) : longint;
  begin
    Vyhra := 1;
  end;

procedure printA;
  var i,j : integer;
  begin
    for i:=1 to MaxPocetKol do
      begin
        for j := 1 to MaxPocetHracu do
          write(a[i,j]:4);
        writeln;
      end;  
  end;
  
begin

{
  for i:=1 to MaxPocetKol do
    for j := 1 to MaxPocetHracu do
      a[i,j] := 0;
}

  for i:=1 to 6 do
    begin
      a[1,i] := Vyhra(i-1, i);
    end;

  printA;
  writeln;
  write(a[2,2]);
  exit;
  {
  kola := 3;

  for k := 2 to kola do
    for n := 1 to MaxPocetHracu do
      begin
        max := 0;
        argmax := 0;
        
        for v:=0 to n-1 do
          begin
            body := (a[k-1, n-v]).vyhra + Vyhra(v,n);
            if body >= max then
              begin
                max := body;
                argmax := v;
              end;
          end;
          
        (a[k,n]).vyhra := max;
        (a[k,n]).vyrazeno := argmax;
      end;

  k := kola;
  n := MaxPocetHracu;
  for i := k downto 1 do
    begin
      write(a[k,n].vyhra, ' ');
      n:= n-v;
    end;
       }
end.