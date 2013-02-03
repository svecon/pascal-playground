program p05;
uses SysUtils;

var n : word;
var x : longint;
var s : string;
var i : integer;

function charToInt(c: char):integer;
  begin charToInt := ord(c) - ord('0'); end;
  
function intToChar(i: longint):char;
  begin intToChar := chr(i + ord('0')); end;
  
function toDec(x:longint; soustava : integer):longint;
  var s : string;
  var i : integer;
  begin
    s := IntToStr(x);
    x := 0;
    
    for i:=1 to ord(s[0]) do
      begin
        x:= (x * soustava) + charToInt(s[i]);
      end;
      
  toDec := x;
      
  end;
  

begin

  read(n);
  
  s := '';
  
  while n <> 0 do
      begin
        s := s + intToChar(n mod 2);
        n := n div 2;
      end;
    
  if s = '' then s := '0';
  
  x := 0;
  for i:=1 to length(s) do
    begin
      x:= (x * 2) + charToInt(s[i]);
    end;
  
  write(x);

end.