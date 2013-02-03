(*
Množiny budou v této úloze reprezentovány spojovými seznamy vzestupne setrídenými podle hodnot. Prvky techto seznamu jsou definovány v knihovne spojak.pas a vypadají následovne:


	PItem = ^TItem;

	TItem = record
		val: LongInt;	{ hodnota prvku }
		next: PItem;	{ ukazatel na dalsi prvek mnoziny }
	end;
Množina je vždy uložena (predávána) jako ukazatel na první prvek spojového seznamu. Prázdný (nilový) ukazatel predstavuje prázdnou množinu. Vašim úkolem je naimplementovat ctyri množinové operace: sjednocení (union) a prunik (intersection) v normálních a destruktivních variantách:


	function union(S1, S2: PItem): PItem;
	function intersection(S1, S2: PItem): PItem;
	function unionDestruct(var S1, S2: PItem): PItem;
	function intersectionDestruct(var S1, S2: PItem): PItem;
Klasické varianty operací (tzn. union a intersection) dostanou dve množiny a jejich cílem je vytvorit novou množinu predstavující sjednocení (resp. prunik) a vrátit jejich ukazatele na první prvky. Všechny prvky ve výsledné množine je potreba zaalokovat (tj. puvodní množiny musí zustat nezmenené).

Destruktivní varianty operací (tzn. unionDestruct a intersectionDestruct) naopak žádná data nealokují a výslednou množinu musí sestavit výhradne použitím prvku ze vstupních množin pouze prepojením ukazatelu. Prvky, které nejsou potreba ve výsledné množine musí destruktivní funkce odalokovat (pomocí dispose). Hodnoty promenných S1 a S2 musí být nastaveny na nil.

Pozor, v této úloze neodevzdáváte program, ale pouze unitu, obsahující implementaci výše uvedených funkcí. Za tímto úcelem si stáhnete šablonu této unity reseni.pas, ve které je již nadefinováno vše potrebné. Vašim úkolem je pouze dopsat tela potrebných funkcí. Funkce nemusíte implementovat všechny - za každou správne naimplementovanou funkci dostanete ctvrtinu z celkového poctu bodu. Pokud nekterou funkci implementovat nechcete, nemente její telo. Pomocné datové typy si mužete deklarovat v cásti implementation. Pomocné promenné definujte výhradne jako lokální (u každé funkce zvlášt).

Pozn: pametové limity jsou nastaveny velice nízko, takže si pro své potreby mužete zaalokovat pouze O(1) pameti. U destruktivních variant se rozhodne nevejde do pameti výsledek spolecne se vstupem, takže není možné napr. jednoduše použít nedestruktivní variantu algoritmu, která teprve po skoncení práce zlikviduje vstupní množiny.
*)

program pn_06_seznamy_test;
uses pn_06_seznamy_reseni, pn_06_seznamy_spojak;

procedure VytiskniSeznam( seznam: PItem );
var p: PItem;
begin
   p := seznam;
   while p<>NIL do
   begin
      write( p^.val,' ' );
      p := p^.next;
   end;
   writeln;
end;

procedure PridejPrvekNaZacatek( x: integer; var seznam: PItem );
var p: PItem;
begin
   new( p );
   p^.val := x;
   p^.next := seznam;
   seznam := p
end;

var
   s1, s2, p: PItem;
begin

   s1 := NIL;
   s2 := nil;

   PridejPrvekNaZacatek( 7, s1 );
   PridejPrvekNaZacatek( 5, s1 );
   PridejPrvekNaZacatek( 3, s1 );
   PridejPrvekNaZacatek( 1, s1 );
   
   PridejPrvekNaZacatek( 7, s2 );
   PridejPrvekNaZacatek( 5, s2 );
   PridejPrvekNaZacatek( 2, s2 );
   PridejPrvekNaZacatek( 0, s2 );

   VytiskniSeznam( s1 );
   VytiskniSeznam( s2 );
   VytiskniSeznam(unionDestruct(s1,s2));
   VytiskniSeznam(intersectionDestruct(s1,s2));
end.