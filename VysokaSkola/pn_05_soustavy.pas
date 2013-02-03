{
Napi�te program, kter� precte ze vstupu dve dvojice cel�ch c�sel bez znam�nka ud�vaj�c�ch v�dy soustavu (2..10) a z�pis c�sla v dan� soustave a d�le c�slo ud�vaj�c� soustavu, ve kter� vytiskne soucet, rozd�l, soucin a pod�l zadan�ch c�sel, ka�d� v�sledek na zvl�tn� r�dek.

Pr�klad:
Vstup: 
5 11 2 101 7

V�stup: 
14
1
42
1
}

program pn_05_soustavy;
uses SysUtils;

type TN = record
    n : longint;
    soustava : integer;
  end;

var a,b : TN;
var soustavaOut : integer;

function charToInt(c: char):integer;
  begin charToInt := ord(c) - ord('0'); end;
  
function intToChar(i: longint):char;
  begin intToChar := chr(i + ord('0')); end;
  
procedure toDec(var x:TN);
  var s : string;
  var i : integer;
  begin
    s := IntToStr(x.n);
    x.n := 0;
    
    for i:=1 to ord(s[0]) do
      begin
        x.n:= (x.n * x.soustava) + charToInt(s[i]);
      end;
      
    x.soustava := 10;    
  end;
  
function toCustom(n:longint; soustava:integer):longint;
  var s : string;
  begin
    s := '';
    
    while n <> 0 do
      begin
        s := intToChar(n mod soustava) + s;
        n := n div soustava;
      end;
    
    toCustom := strToInt(s);
  end;   

begin
  read(a.soustava, a.n, b.soustava, b.n, soustavaOut);
  
  toDec(a);
  toDec(b);
  
  writeln(toCustom(a.n+b.n, soustavaOut));
  writeln(toCustom(a.n-b.n, soustavaOut));
  writeln(toCustom(a.n*b.n, soustavaOut));
  writeln(toCustom(a.n div b.n, soustavaOut)); 
end.    