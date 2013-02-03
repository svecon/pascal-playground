{
Úcastníte se souteže, ve které máte proti sobe sto souperu. Soutež bude trvat k kol. V každém kole mužete nekteré soupere vyradit ze souteže (vždy nejméne jednoho) a za jejich vyrazení dostanete odmenu.

Odmena za vyrazení v souperu z poctu p je

100.000,- * v / p

Pocítáno v celých císlech (tzn. dolní celá cást).

Tedy napríklad když v prvním kole vyradíte 50 souperu z pocátecních 100, získáte 50.000,-. Když ve druhém kole ze zbylých 50 vyradíte 30, získáte 100.000,- * 30/50 = 60.000,- a máte celkem 110.000,- Když v posledním kole vyradíte posledních 20 souperu, získáte 100.000,- * 20/20 = 100.000,- a váš celkový zisk bude 210.000,-

Napište program, který pro zadaný pocet kol urcí a vytiskne maximální možný zisk a na další rádek pocty souperu (oddelené mezerou), které máte vyrazovat v jednotlivých kolech.

Príklad:
Vstup:
  3
Výstup:
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