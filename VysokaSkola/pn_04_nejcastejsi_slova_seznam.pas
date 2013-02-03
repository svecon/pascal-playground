{
Ctete vstupní textový soubor text.in a pro dvacet nejcetnejších slov v nem urcete jejich cetnost. Tato nejcetnejší slova spolu s jejich cetnostmi zapište na výstup v poradí podle klesající cetnosti. Pokud mají dve ruzná slova shodnou cetnost, je lhostejno, které z nich do výstupní dvacítky vyberete, a je lhostejno, v jakém poradí je na výstup zapíšete.

Slovem zde rozumíme libovolnou souvislou posloupnost písmen, pokud znak, který jí v souboru bezprostredne predchází, ani znak, který ji v souboru bezprostredne následuje, nejsou písmena. Za písmena zde považujeme pouze znaky anglické abecedy. Pri porovnávání dvou slov bereme do úvahy i rozdíl mezi malým a velkým písmenem. Predpokládejte, že a) pocet ruzných slov ve vstupním souboru bude nejméne 1 a nebude vetší než 1000, b) žádné slovo ve vstupním souboru nebude delší než 30 písmen.

Výsledek zapište na standardní výstup. Na každý rádek výstupu zapište slovo a jeho cetnost, císlo od slova oddelte mezerou. Jestliže vstupní soubor obsahuje méne než 20 ruzných slov, na výstupu bude pouze tolik slov, kolik se ve vstupním souboru nachází.

Požadavek: Vstupní soubor ctete pouze jednou.


Príklad vstupního souboru:

A computer file is a block of arbitrary information, or resource for storing information, which is available to a computer program and is usually based on some kind of durable storage. A file is durable in the sense that it remains available for programs to use after the current program has finished. Computer files can be considered as the modern counterpart of paper documents which traditionally are kept in offices' and libraries' files, and this is the source of the term. 
At the lowest level, many modern operating systems consider files simply as a one-dimensional sequence of bytes. At a higher level, where the content of the file is being considered, these binary digits may represent integer values, text characters, image pixels, audio or anything else. It is up to the program using the file to understand the meaning and internal layout of information in the file and present it to a user as more meaningful information (such as text, images, sounds, or executable application programs). 
At any instant in time, a file might have a size, normally expressed as number of bytes, that indicates how much storage is associated with the file. In most modern operating systems the size can be any non-negative whole number of bytes up to a system limit. However, the general definition of a file does not require that its instant size has any real meaning, unless the data within the file happens to correspond to data within a pool of persistent storage.
Správný výstup muže vypadat napr. takto:

the 17
of 11
a 10
file 9
is 8
to 8
and 5
as 5
information 4
in 4
or 3
program 3
storage 3
that 3
files 3
modern 3
At 3
bytes 3
any 3
size 3

Jiný príklad vstupního souboru:

aA Aa AAA aaa aAa 1a 2a 3aa
A AaA AaA aa aAa 1A 2A 3AA
Správný výstup muže vypadat napr. takto:

A 3
aAa 2
a 2
aa 2
AaA 2
aA 1
Aa 1
AAA 1
aaa 1
AA 1
}

program pn_04_nejcastejsi_slova;

type
  Pword = ^Tword;
  Tword = record
    str:string[31];
    c:integer;
    prev,next : Pword;
  end;
 
var list : Pword;
var w : Tword;

var f : text;
var c : char;
var s : string; 
var count,i,p : integer;

function isLetter(c:char):boolean;
  begin
    isLetter := false;
    if c in ['a'..'z', 'A'..'Z'] then isLetter := true;
  end;
  
function wordExists(s:string):Pword;
  var p : Pword;
  begin
    wordExists := NIL;
    p := list;
    
    while p <> NIL do
      begin
        if p^.str = s then
          begin
            wordExists := p;
            break;
          end;
        p := p^.next;
      end;
  end;
  
procedure addWord(var s:string);
  var p,n : Pword;
  begin
    p := wordExists(s);
    
    if p = NIL then
      begin
        new (n);
        n^.str := s;
        n^.c := 1;
        n^.next := list;
        n^.prev := NIL;
        if list <> NIL then list^.prev := n;
        list := n;
        count := count + 1;         
      end
    else p^.c := p^.c + 1;
    s := '';    
  end;
  
function mostCommonWord():Tword;
  var max : integer;
  var p, maxP : Pword;
  begin
    p := list;
    max := p^.c;
    maxP := p;
    p := p^.next;
    
    while p <> NIL do
      begin
        if p^.c > max then
          begin
            max := p^.c;
            maxP := p;
          end;
        p := p^.next;
      end;

    mostCommonWord := maxP^;
    maxP^.c := -1;
  end;

begin
  assign(f, 'pn_04_text.in'); reset(f);
  count := 0;
  s := '';

  while not eof(f) do
    begin
      read(f, c);
      if isLetter(c) then s := s + c
      else if s <> '' then addWord(s);
    end;
  if s <> '' then addWord(s);
  close(f);

  p := 20;
  if count < p then p := count;
  
  for i:=1 to p do
    begin 
      w := mostCommonWord();
      writeln(w.str, ' ', w.c);
    end;
    
    readln;
end.