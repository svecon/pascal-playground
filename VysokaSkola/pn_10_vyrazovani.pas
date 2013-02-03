{
�castn�te se soute�e, ve kter� m�te proti sobe sto souperu. Soute� bude trvat k kol. V ka�d�m kole mu�ete nekter� soupere vyradit ze soute�e (v�dy nejm�ne jednoho) a za jejich vyrazen� dostanete odmenu.

Odmena za vyrazen� v souperu z poctu p je

100.000,- * v / p

Poc�t�no v cel�ch c�slech (tzn. doln� cel� c�st).

Tedy napr�klad kdy� v prvn�m kole vyrad�te 50 souperu z poc�tecn�ch 100, z�sk�te 50.000,-. Kdy� ve druh�m kole ze zbyl�ch 50 vyrad�te 30, z�sk�te 100.000,- * 30/50 = 60.000,- a m�te celkem 110.000,- Kdy� v posledn�m kole vyrad�te posledn�ch 20 souperu, z�sk�te 100.000,- * 20/20 = 100.000,- a v� celkov� zisk bude 210.000,-

Napi�te program, kter� pro zadan� pocet kol urc� a vytiskne maxim�ln� mo�n� zisk a na dal�� r�dek pocty souperu (oddelen� mezerou), kter� m�te vyrazovat v jednotliv�ch kolech.

Pr�klad:
Vstup:
  3
V�stup:
  280000
  90 9 1
}

program pn_10_vyrazovani;
uses sysutils;

const ODMENA = 100000;

var K: integer; {pocet kol}
{var a: array[1..100] of string;

procedure printA(pocetKol : integer);
  var i : integer;
  begin
    for i := pocetKol downto 1 do
      write(a[i], ' ');  
  end;
}
function Vyhra(vyrazeno,hraci : integer) : longint;
  begin
    Vyhra := (ODMENA * vyrazeno) div hraci;
  end;

function Zisk(zbyvaKol, zbyvaHracu:integer):longint;
  var max,skore : longint;
  var vyrazeno : integer;
begin
  if (zbyvaHracu = 1) or (zbyvaKol = 1) then
    begin
      Zisk := Vyhra(zbyvaHracu, zbyvaHracu);
      exit;
    end;

  max := 0;
  for vyrazeno := 1 to zbyvaHracu - 1 do
    begin
      skore := Vyhra(vyrazeno, zbyvaHracu) + Zisk(zbyvaKol - 1, zbyvaHracu - vyrazeno);
      {a[zbyvaKol] := inttostr(vyrazeno)+'/'+inttostr(zbyvaHracu);  
      printA(K); writeln(' [', skore ,']');}
      if skore > max then
        begin
          max := skore;
          {a[zbyvaKol] := inttostr(vyrazeno)+'/'+inttostr(zbyvaHracu);}
        end;
    end;

  Zisk := max;
end;


begin
  read(K);
  writeln(Zisk(K, 100));
  {printA(K);}
end.