(*
Mno�iny budou v t�to �loze reprezentov�ny spojov�mi seznamy vzestupne setr�den�mi podle hodnot. Prvky techto seznamu jsou definov�ny v knihovne spojak.pas a vypadaj� n�sledovne:


	PItem = ^TItem;

	TItem = record
		val: LongInt;	{ hodnota prvku }
		next: PItem;	{ ukazatel na dalsi prvek mnoziny }
	end;
Mno�ina je v�dy ulo�ena (pred�v�na) jako ukazatel na prvn� prvek spojov�ho seznamu. Pr�zdn� (nilov�) ukazatel predstavuje pr�zdnou mno�inu. Va�im �kolem je naimplementovat ctyri mno�inov� operace: sjednocen� (union) a prunik (intersection) v norm�ln�ch a destruktivn�ch variant�ch:


	function union(S1, S2: PItem): PItem;
	function intersection(S1, S2: PItem): PItem;
	function unionDestruct(var S1, S2: PItem): PItem;
	function intersectionDestruct(var S1, S2: PItem): PItem;
Klasick� varianty operac� (tzn. union a intersection) dostanou dve mno�iny a jejich c�lem je vytvorit novou mno�inu predstavuj�c� sjednocen� (resp. prunik) a vr�tit jejich ukazatele na prvn� prvky. V�echny prvky ve v�sledn� mno�ine je potreba zaalokovat (tj. puvodn� mno�iny mus� zustat nezmenen�).

Destruktivn� varianty operac� (tzn. unionDestruct a intersectionDestruct) naopak ��dn� data nealokuj� a v�slednou mno�inu mus� sestavit v�hradne pou�it�m prvku ze vstupn�ch mno�in pouze prepojen�m ukazatelu. Prvky, kter� nejsou potreba ve v�sledn� mno�ine mus� destruktivn� funkce odalokovat (pomoc� dispose). Hodnoty promenn�ch S1 a S2 mus� b�t nastaveny na nil.

Pozor, v t�to �loze neodevzd�v�te program, ale pouze unitu, obsahuj�c� implementaci v��e uveden�ch funkc�. Za t�mto �celem si st�hnete �ablonu t�to unity reseni.pas, ve kter� je ji� nadefinov�no v�e potrebn�. Va�im �kolem je pouze dopsat tela potrebn�ch funkc�. Funkce nemus�te implementovat v�echny - za ka�dou spr�vne naimplementovanou funkci dostanete ctvrtinu z celkov�ho poctu bodu. Pokud nekterou funkci implementovat nechcete, nemente jej� telo. Pomocn� datov� typy si mu�ete deklarovat v c�sti implementation. Pomocn� promenn� definujte v�hradne jako lok�ln� (u ka�d� funkce zvl�t).

Pozn: pametov� limity jsou nastaveny velice n�zko, tak�e si pro sv� potreby mu�ete zaalokovat pouze O(1) pameti. U destruktivn�ch variant se rozhodne nevejde do pameti v�sledek spolecne se vstupem, tak�e nen� mo�n� napr. jednodu�e pou��t nedestruktivn� variantu algoritmu, kter� teprve po skoncen� pr�ce zlikviduje vstupn� mno�iny.
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