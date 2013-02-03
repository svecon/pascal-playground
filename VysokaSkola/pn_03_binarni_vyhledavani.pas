program pn_03_binarni_hledani_setridene_pole;

{
Ze standardního vstupu dostanete na prvním řádku čísla N a k oddělená mezerou, kde N představuje počet čísel a k počet dotazů. Na druhém řádku se nachází mezerami oddělených N čísel setříděných vzestupně (data) a na třetím řádku pak následuje k dotazů na tato čísla.

Načtěte si data do paměti a následně pro každý dotaz x nalezněte jeho pozici i v datech (tzn. hledáme i, pro které platí, že data[i] = x). Pozice jsou indexovány od 1 do N.

Všechny nalezené indexy vypište v desítkovém formátu na standardní výstup oddělené mezerami. Pokud nějaké hledané číslo v datech není, uložíte místo pozice číslo 0. Pokud se v datech vyskytuje hledané číslo víckrát, vratíte index prvního z nich. Všechna čísla se vejdou do 32-bit integeru. Velikost dat N a počet dotazů k bude nejvýše 1 000 000.

Příklad:
vstup
  8 5
  2 5 6 6 6 9 13 18
  6 2 3 18 9
výstup
  3 1 0 8 6
Pozn: Pamatujte, že v setříděném poli lze vyhledávat rychleji, než v nesetříděném (na časovou složitost algoritmu bude brán zřetel).

}

var N,k,i,dotaz : longint;
var cisla: array of longint;

function hledej(var x:longint; l,r : longint):longint;
  var stred : longint;
  begin
    if (l>r) then hledej := 0
    else
      begin
        stred := (l + r) div 2;
        
        if cisla[stred] > x then
          hledej := hledej(x, l, stred-1)
        else if cisla[stred] < x then
          hledej := hledej(x, stred+1, r)
        else // s[stred] == x
          begin
            while cisla[stred-1] = x do
              stred := stred-1;
            hledej := stred;
          end;
      end;
  end;

begin

  read(N, k);
  setLength(cisla, N+1);
  
  for i:=1 to N do
    read(cisla[i]);

  for i:=1 to k do
    begin
      read(dotaz);
      write(hledej(dotaz, 1, N), ' ');
    end; 
  
end.