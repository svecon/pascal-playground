program p04;
var n,m,i,j : integer;
function zanor(x,y,i,j : integer; plus : longint):longint;
  var val : longint;
  begin
    if (i=1) or (i=x) or (j=1) or (j=y) then
      begin
        if j=1 then val := i
        else if i=x then val := x + j - 1
        else if j=y then val := x + y - 1 + (x - i + 1) - 1
        else val := x + y -1 + x - 1 + (y - j);  
      end
    else val := zanor(x-2,y-2,i-1,j-1, (2*x)+(2*y)-4);
    zanor := plus + val;
  end;
begin
  read(n,m,i,j);
  write(zanor(n,m,i,j,0));
end.