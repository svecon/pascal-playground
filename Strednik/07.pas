program p07;
uses math;

var d,m,y : integer;
var nm: longint;
var nd,ny : extended;
var x : longint;
var i : integer;

function g(y : extended;m:longint;d:extended):extended;
  begin
    m := (m + 9) mod 12;
    y := y - m/10;
    g := 365*y + y/4 - y/100 + y/400 + (m*306 + 5)/10 + ( d - 1 );
  end;

procedure dny(g:extended;var dd:extended;var mm:longint; var y : extended);
var ddd,mi : extended;
  begin
    y := (10000*g + 14780)/3652425;
    ddd := g - (365*y + y/4 - y/100 + y/400);
    
    if (ddd < 0) then
      begin
      y := y - 1;
      ddd := g - (365*y + y/4 - y/100 + y/400)
      end;

    mi := (100*ddd + 52)/3060;
    mm := round((mi + 2)) mod 12 + 1;
    y := y + (mi + 2)/12;
    dd := ddd - (mi*306 + 5)/10 + 1;
  end;

begin

read(d,m,y);
read(x);

dny(x+g(y,m,d), nd, nm, ny);

if round(nd) = 0 then nd := 1;
write(round(nd), ' ', round(nm), ' ', round(ny));

end.