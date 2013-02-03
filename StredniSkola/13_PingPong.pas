program PingPong;
uses crt;

var ch: char;
var i,j,k,l,domaciSety,hosteSety, domaciMice, hosteMice:integer;

function nula (x,y:integer) : integer;
  begin
    gotoxy(x,y);
    write('000');
    gotoxy(x,y+1);
    write('0 0');
    gotoxy(x,y+2);
    write('0 0');
    gotoxy(x,y+3);
    write('0 0');
    gotoxy(x,y+4);
    write('000');
  end;
function jedna (x,y:integer) : integer;
  begin
    gotoxy(x,y);
    write('  1');
    gotoxy(x,y+1);
    write(' 11');
    gotoxy(x,y+2);
    write('1 1');
    gotoxy(x,y+3);
    write('  1');
    gotoxy(x,y+4);
    write('  1');
  end;
function dva (x,y:integer) : integer;
  begin
    gotoxy(x,y);
    write('222');
    gotoxy(x,y+1);
    write('  2');
    gotoxy(x,y+2);
    write('222');
    gotoxy(x,y+3);
    write('2  ');
    gotoxy(x,y+4);
    write('222');
  end;
function tri (x,y:integer) : integer;
  begin
    gotoxy(x,y);
    write('333');
    gotoxy(x,y+1);
    write('  3');
    gotoxy(x,y+2);
    write('333');
    gotoxy(x,y+3);
    write('  3');
    gotoxy(x,y+4);
    write('333');
  end;
function smazCislo (x,y:integer) : integer;
  begin
    gotoxy(x,y);
    write('   ');
    gotoxy(x,y+1);
    write('   ');
    gotoxy(x,y+2);
    write('   ');
    gotoxy(x,y+3);
    write('   ');
    gotoxy(x,y+4);
    write('   ');
  end;

function stav (domaci, hoste :integer ) : integer;
  begin
    gotoxy(18, 7);
    write(domaci:2, ' : ', hoste:2);
  end;

function sety (domaci, hoste :integer) : integer;
var y, x1, x2 :integer;
  begin
    y:=10;
    x1:=10;
    x2:=30;

    case domaci of
      0: nula(x1,y);
      1: jedna(x1,y);
      2: dva(x1,y);
      3: tri(x1,y);
    end;

    case hoste of
      0: nula(x2,y);
      1: jedna(x2,y);
      2: dva(x2,y);
      3: tri(x2,y);
    end;
  end;

function nachystat () : integer;
  begin
    clrscr;
    gotoxy(5, 3);
    write('Dom c¡ hr Ÿ');
    gotoxy(25, 3);
    write('Hostuj¡c¡ hr Ÿ');
    stav(domaciMice, hosteMice);
    sety(domaciSety, hosteSety);
  end;

begin

domaciMice := 0;
hosteMice := 0;
domaciSety := 0;
hosteSety := 0;

nachystat();

repeat
    begin
      ch:=readkey;
      if ch='a' then domaciMice := domaciMice +1
      else if ch='b' then hosteMice := hosteMice +1
      else if ch='x' then domaciSety:=3;

      if (domaciMice>10) AND (domaciMice-hosteMice>1) then
        begin
          domaciSety:=domaciSety+1;
          domaciMice:=0;
          hosteMice:=0;
        end
      else if (hosteMice>10) AND (hosteMice-domaciMice>1) then
        begin
          hosteSety:=hosteSety+1;
          hosteMice:=0;
          domaciMice:=0;
        end;

      stav(domaciMice, hosteMice);
      sety(domaciSety, hosteSety);
    end;
until (domaciSety=3) OR (hosteSety=3);

if ch<>'x' then readkey;

end.
