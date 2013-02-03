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

type Tword = record
    s:string[31];
    c:integer;
  end;
  
var a : array[1..1000] of Tword;
var w : Tword;
var count,i,p : integer;
var f : text;
var c : char;
var s : string;

function isLetter(c:char):boolean;
  begin
    isLetter := false;
    if c in ['a'..'z', 'A'..'Z'] then isLetter := true;
  end;
  
function wordExists(s:string):integer;
  var i : integer;
  begin
    wordExists := -1;
    for i:=1 to count do
      if a[i].s = s then begin
        wordExists := i;
        break;
      end;    
  end;
  
procedure addWord(s:string);
  var i : integer;
  begin
    i := wordExists(s);
    if i = -1 then
      begin
        count := count + 1;
        a[count].s := s;
        a[count].c := 1;          
      end
    else a[i].c := a[i].c + 1;    
  end;
  
function mostCommonWord():tWord;
  var max, maxI, i : integer;
  begin
    max := a[1].c;
    maxI := 1;
    for i:=2 to count do
      begin
        if a[i].c > max then
          begin
            maxI := i;
            max := a[i].c;
          end; 
      end;
      
    mostCommonWord := a[maxI];
    
    a[maxI] := a[count];
    count := count - 1;
        
  end;

begin
  assign(f, 'pn_04_text.in');
  reset(f);
  
  count := 0;
  s := '';
  
  while not eof(f) do
    begin
      read(f, c);
      if isLetter(c) then s := s + c
      else if s <> '' then
        begin
          addWord(s);
          s := '';
        end;
    end;
  if s <> '' then addWord(s);
  
  close(f);

  p := 20;
  if count < p then p := count;
  
  for i:=1 to p do
    begin 
      w := mostCommonWord();
      writeln(w.s, ' ', w.c);
    end;
    
    readln;

end.